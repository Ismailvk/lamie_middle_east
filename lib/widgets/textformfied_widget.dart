import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final FormFieldValidator<String?>? validator;
  final TextEditingController controller;
  final bool isLabel;
  final String hintText;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.validator,
      required this.isLabel,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            label: isLabel ? Text(hintText) : const SizedBox(),
            hintText: hintText,
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
