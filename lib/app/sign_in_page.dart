import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_tracker_app/common_widgets/sign_in_button.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.onSignIn, @required this.auth}) : super(key: key);

  final AuthBase auth;

  final void Function(User) onSignIn;

  Future<void> _signInAnonymously() async {
    try {
      final user = await auth.signInAnonymously();
      this.onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Time Tracker'),
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text('Sign in',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),

            Spacer(),
            SignInButton(
              title: 'Sign in with Google',
              primaryColor: Colors.orange,
              onPressed: () {},
            ),
            Gap(13),
            SignInButton(
              title: 'Sign in with Facebook',
              primaryColor: Colors.blueAccent,
              onPressed: () {},
            ),
            Gap(13),
            SignInButton(
              title: 'Sign in with Email',
              primaryColor: Colors.green,
              onPressed: () {},
            ),
            Gap(30),
            Text('Or',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            Gap(20),
            SignInButton(
              title: 'Continue anonymously',
              onPressed: _signInAnonymously,
              primaryColor: Colors.blueGrey,
            ),
            Gap(35),
          ],
        ),
      ),
    );
  }
}
