import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final FormControl<T>? formControl;
  final String? formControlName;
  final bool obscureText;
  final TextInputType inputType;
  final String label;
  final String isEmpty;
  final String validate;

  const CustomTextField({
    super.key,
    this.controller,
    this.formControl,
    this.formControlName,
    this.obscureText = false,
    required this.label,
    this.inputType = TextInputType.text,
    this.isEmpty= '',
    this.validate= '',
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 150.0,
        child: ReactiveTextField(
          controller: controller,
          formControl: formControl,
          formControlName: formControlName,
          decoration: InputDecoration(
            labelText: label,
            enabledBorder: _border(context),
            border: _border(context),
            focusedBorder: _border(context),
            contentPadding: const EdgeInsets.all(8),
          ),
          keyboardType: inputType,
          obscureText: obscureText,
          validationMessages: {
            'required': (error) => isEmpty,
            'email': (error) => validate,
          },
        ),
      );

  InputBorder _border(BuildContext context) => OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
      );
}
