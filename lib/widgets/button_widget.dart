import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String title;
  Function()? onPress;
  ButtonWidget({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height / 15,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor)),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
