import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? obscureText;
  void Function(String)? onChanged;
  void Function()? onTap;
  final String? validationString;

  bool readOnly;
  RoundedTextField(
      {Key? key,
      required this.hintText,
      this.icon,
      required this.inputType,
      required this.controller,
      required this.validationString,
      this.onChanged,
      this.onTap,
      this.obscureText,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationString;
        }
        return null;
      },
      textAlign: TextAlign.center,
      obscureText: obscureText != null ? obscureText! : false,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 10, left: 10),
        hintText: hintText,
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(height: 30, child: icon))
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.red, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
      keyboardType: inputType,
    );
  }
}
