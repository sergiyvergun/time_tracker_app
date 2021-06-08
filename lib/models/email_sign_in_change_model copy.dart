import 'package:flutter/material.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/components/email_sign_in_form_change_notifier.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/utils/validators.dart';

import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  String get primaryButtonText =>
      formType == EmailSignInFormType.signIn ? 'Sign in' : 'Create an account';

  String get secondaryButtonText =>
      formType == EmailSignInFormType.signIn ? 'Register' : 'Sign in';

  bool get canSubmit =>
      emailValidator.isValid(email) &&
      passwordValidator.isValid(password) &&
      !isLoading;

  String get passwordErrorText =>
      submitted && passwordValidator.isValid(password)
          ? invalidPasswordErrorText
          : null;

  String get emailErrorText =>
      submitted && emailValidator.isValid(email) ? invalidEmailErrorText : null;

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType() {
    updateWith(
      formType: this.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      email: '',
      password: '',
      isLoading: false,
      submitted: false,
    );
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        await auth.createUserWithEmailAndPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
