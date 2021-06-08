import 'package:flutter/material.dart';
import 'package:time_tracker_app/components/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign in with email',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EmailSignInFormChangeNotifier.create(context),
            ],
          ),
        ),
      ),
    );
  }
}
