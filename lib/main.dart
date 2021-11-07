import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/jobs_page.dart';
import 'package:time_tracker_app/services/auth.dart';

import 'app/landing_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
            primarySwatch: Colors.green,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.blueGrey),
                color: Colors.white,
                elevation: 0,
                centerTitle: false,
                titleTextStyle: TextStyle(color: Colors.black87))),
        home: LandingPage(),
      ),
    );
  }
}
