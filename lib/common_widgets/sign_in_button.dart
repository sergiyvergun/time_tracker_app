import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color primaryColor;

  const SignInButton({
    Key key,
    @required this.title,
    this.onPressed,
    this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          elevation: 0,
          primary: Colors.white,
          backgroundColor: primaryColor),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
