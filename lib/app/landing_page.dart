import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';

import 'home/jobs/jobs_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: Provider.of<Auth>(context).authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;

            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
          }

          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
