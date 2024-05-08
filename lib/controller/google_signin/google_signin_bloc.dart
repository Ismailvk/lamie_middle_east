import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:lamie_middle_east/repositories/user_repo.dart';
part 'google_signin_event.dart';
part 'google_signin_state.dart';

class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  GoogleSigninBloc() : super(GoogleSigninInitial()) {
    on<GoogleUserSigninEvent>(signinUsingGoogleEvent);
    on<GoogleUserSignOutEvent>(googleUserSignOutEvent);
    on<PassLoginDetailsToApiEvent>(passLoginDetailsToApiEvent);
  }

  FutureOr<void> signinUsingGoogleEvent(
      GoogleUserSigninEvent event, Emitter<GoogleSigninState> emit) async {
    emit(GoogleSigninLoadingState());

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;
      print('access token is $accessToken');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final userEmail = userCredential.user?.email;

      SharedPref.instance.storeAccessToken(accessToken!);

      emit(GoogleSigninSuccessState(
          accessToken: accessToken, email: userEmail!));
    } on FirebaseAuthException catch (e) {
      emit(GoogleSigninFailedState(
          errorMessage: e.message ?? 'Firebase Auth Error'));
    } catch (e) {
      emit(GoogleSigninFailedState(errorMessage: 'Something went wrong'));
    }
  }

//-----------------------//
  FutureOr<void> googleUserSignOutEvent(
      GoogleUserSignOutEvent event, Emitter<GoogleSigninState> emit) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPref.instance.removeToken();
      emit(GoogleSignOutSuccessState());
    } on Exception catch (_) {
      emit(GoogleSignOutFailedState());
    }
  }

  FutureOr<void> passLoginDetailsToApiEvent(
      PassLoginDetailsToApiEvent event, Emitter<GoogleSigninState> emit) async {
    final either = await UserRepo().googleSignin(event.map);
    either.fold(
        (error) =>
            emit(PassLoginDetailsToApiFailedState(errorMessage: error.message)),
        (response) {
      print(response);
      if (response['status'] == 200) {
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(response['token']['access']);

        SharedPref.instance.storeToken(response['token']['access']);
        print(
            '------------------------------ Token ${response['token']['access']}');
        print(
            '------------------------------ User Id ${decodedToken['user_id']}');

        emit(PassLoginDetailsToApiSuccessState());
      } else {
        emit(PassLoginDetailsToApiFailedState(
            errorMessage: 'somthing went wrong'));
      }
    });
  }
}
