import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_tracker_app/common_widgets/sign_in_button.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithGoogle() async {
    try {
     await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithFacebook() async {
    try {
     await auth.signInWithFacebook();
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
              primaryColor: Colors.orange[400],
              onPressed: _signInWithGoogle,
            ),
            Gap(13),
            SignInButton(
              title: 'Sign in with Facebook',
              primaryColor: Colors.blueAccent[200],
              onPressed: _signInWithFacebook,
            ),
            Gap(13),
            SignInButton(
              title: 'Sign in with Email',
              primaryColor: Colors.green[400],
              onPressed: () {},
            ),
            Gap(30),
            Text('Or',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            Gap(20),
            SignInButton(
              title: 'Continue anonymously',
              onPressed: _signInAnonymously,
              primaryColor: Colors.blueGrey[400],
            ),
            Gap(35),
          ],
        ),
      ),
    );
  }
}
