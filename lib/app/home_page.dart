import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';

class HomePage extends StatelessWidget {

  final VoidCallback onSignOut;
  final AuthBase auth;
  const HomePage({Key key,@required this.onSignOut, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: <Widget>[
          TextButton(
            onPressed:  _signOut,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign out',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
       await auth.signOut();
       this.onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
