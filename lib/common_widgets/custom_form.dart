import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool autocorrect;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String value) onChanged;
  final String errorText;
  final bool enabled;

  const CustomForm({Key key, this.hintText, this.obscureText, this.controller, this.autocorrect=false, this.keyboardType, this.textInputAction, this.onChanged, this.errorText, this.enabled=true,}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return TextField(

      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      controller: controller,
      obscureText: obscureText??false,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabled: enabled,
errorText: errorText,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          filled: true,

          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}
