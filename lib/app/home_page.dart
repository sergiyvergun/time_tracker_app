
import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';

class HomePage extends StatelessWidget {

  final AuthBase auth;
  const HomePage({Key key, @required this.auth}) : super(key: key);

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
    } catch (e) {
      print(e.toString());
    }
  }
}
