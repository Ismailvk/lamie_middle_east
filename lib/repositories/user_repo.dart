import 'package:lamie_middle_east/data/network/api_service.dart';
import 'package:lamie_middle_east/data/network/api_urls.dart';

class UserRepo {
  EitherResponse signupUser(Map<String, dynamic> userData) {
    const url = ApiUrls.signup;
    return ApiService.postApi(userData, url);
  }

  EitherResponse login(Map<String, String> loginData) {
    const url = ApiUrls.login;
    return ApiService.postApi(loginData, url);
  }

  EitherResponse getLoggedUserData(int userId, String token) {
    final url = '${ApiUrls.loggedUserData}/${userId.toString()}/';
    return ApiService.getApi(url, token);
  }

  EitherResponse searchingUser(String searchingString) {
    final url = '${ApiUrls.searching}=$searchingString';
    return ApiService.getApi(url);
  }

  EitherResponse googleSignin(Map<String, String> signinData) {
    const url = ApiUrls.googleSignin;
    return ApiService.postApi(signinData, url);
  }
}
