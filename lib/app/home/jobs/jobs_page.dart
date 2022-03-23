import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _createJob(BuildContext context) async {
    try {
      var database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(name: 'Blogging', ratePerHour: 10));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Jobs',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => confirmSignOut(context),
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
      body: StreamBuilder<List<Job>>(
        stream: context.read<Database>().jobsStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, int index) {
                  return Text(jobs.elementAt(index).name);
                });
          }
          if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          }
          return Center(
              child: Text(
            'No Jobs',
            style: Theme.of(context).textTheme.bodyText1,
          ));
        },
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await Provider.of<Auth>(context, listen: false).signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Log out',
      content: 'Are you sure that you want to log out?',
      defaultActionText: 'Cancel',
      cancelActionText: 'Logout',
    );
    if (didRequestSignOut) {
      await _signOut(context);
    }
  }
}
