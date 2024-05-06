import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';

class GoogleButtonWidget extends StatelessWidget {
  final String title;
  final Function() onPress;
  const GoogleButtonWidget(
      {super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImageStrings.googleImage),
          const SizedBox(width: 8),
          Text(title)
        ],
      ),
    );
  }
}
