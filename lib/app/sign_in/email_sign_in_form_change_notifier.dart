
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/custom_form.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_change_model%20copy.dart';
import 'package:time_tracker_app/services/auth.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, EmailSignInChangeModel model, __) {
          return EmailSignInFormChangeNotifier(model: model);
        },
      ),
    );
  }

  EmailSignInFormChangeNotifier({Key key, @required this.model})
      : super(key: key);

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    model.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> submit() async {
    try {
      await model.submit();
    } catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  EmailSignInChangeModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    bool emailValid = model.emailValidator.isValid(model.email);

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
            onChanged: model.updateEmail,
            errorText: model.emailErrorText,
            enabled: model.isLoading == false,
          ),
          Gap(10),
          CustomForm(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: model.updatePassword,
            errorText: model.passwordErrorText,
            enabled: model.isLoading == false,
          ),
          Gap(10),
          TextButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.primaryButtonText, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            onPressed: model.canSubmit ? model.submit : null,
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blueGrey),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.secondaryButtonText,
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            onPressed: !model.isLoading ? _toggleFormType : null,
          ),
        ],
      ),
    );
  }
}
