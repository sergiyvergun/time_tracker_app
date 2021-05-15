import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/custom_form.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/utils/validators.dart';

enum EmailSignInFormType { signIn, register }

class SignInFormsButtons extends StatefulWidget
    with EmailAndPasswordValidators {


  @override
  _SignInFormsButtonsState createState() => _SignInFormsButtonsState();
}

class _SignInFormsButtonsState extends State<SignInFormsButtons> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_formType == EmailSignInFormType.signIn) {
        await Provider.of<Auth>(context,listen: false).signInWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } else {
        await Provider.of<Auth>(context,listen: false).createUserWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {

        showExceptionAlertDialog(
          context,
          title: 'Sign in failed',
          exception: e,
        );

    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    bool emailValid = widget.emailValidator.isValid(_email);
    bool passwordValid = widget.passwordValidator.isValid(_password);

    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText =
        _formType == EmailSignInFormType.signIn ? 'Register' : 'Sign in';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomForm(
            hintText: "Email",
            controller: _emailController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (String value) => _updateState(),
            errorText: emailValid ? null : widget.invalidEmailErrorText,
            enabled: _isLoading == false,
          ),
          Gap(10),
          CustomForm(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: (String value) => _updateState(),
            errorText: passwordValid ? null : widget.invalidPasswordErrorText,
            enabled: _isLoading == false,
          ),
          Gap(10),
          TextButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(primaryText, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            onPressed: submitEnabled ? _submit : null,
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blueGrey),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(secondaryText, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            onPressed: !_isLoading ? toggleFormType : null,
          ),
        ],
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
