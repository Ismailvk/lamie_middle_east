import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';

topSnackbar(BuildContext context, String message, Color color) {
  return Flushbar(
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: AppColors.white,
    ),
    margin: const EdgeInsets.all(6.0),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(12),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: AppColors.black,
    backgroundColor: color,
  ).show(context);
}
