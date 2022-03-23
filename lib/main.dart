import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/jobs/jobs_page.dart';
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
          scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.green,
            cardTheme: CardTheme(
              color: Colors.grey[100]
            ),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(width: 1.4,color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(12)),
                border:  OutlineInputBorder(
                    borderSide: new BorderSide(),
                    borderRadius: BorderRadius.circular(12))),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.blueGrey),
                color: Colors.white,
                elevation: 0,

                titleTextStyle: TextStyle(fontSize:16,fontWeight:FontWeight.w600,color: Colors.black87))),
        home: LandingPage(),
      ),
    );
  }
}
