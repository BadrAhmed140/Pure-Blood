import 'package:flutter/material.dart';

class EditTextField extends StatelessWidget {
  String  ?editString;
   TextEditingController controller;
Widget Icon;
  EditTextField({ this.editString,required this.Icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: editString,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon:Icon),
    );
  }
}
