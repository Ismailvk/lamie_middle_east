import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingController {
  static bool _isLoading = false;

  static void showLoadingDialog(BuildContext context) {
    if (_isLoading) return; // Prevent showing multiple dialogs
    _isLoading = true;

    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const PopScope(
          canPop: true,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: LoadingIcon(),
          ),
        );
      },
    );
  }

  static void showWebLoadingDialog(BuildContext context) {
    if (_isLoading) return;
    _isLoading = true;

    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 2,
            content: LoadingIconWeb(),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (!_isLoading) {
      return;
    }

    _isLoading = false;
    Navigator.of(
      context,
    ).pop(true);
  }

  static bool isHiding() {
    return _isLoading;
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: AppColors.primaryColor,
        rightDotColor: AppColors.lightGrey,
        size: 75,
      ),
    );
  }
}

class LoadingIconWeb extends StatelessWidget {
  const LoadingIconWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.black,
        size: 55,
      ),
    );
  }
}
