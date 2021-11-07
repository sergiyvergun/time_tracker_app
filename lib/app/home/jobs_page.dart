import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _createJob(BuildContext context) async {
    var database = Provider.of<Database>(context, listen: false);
    await database.createJob(Job(name: 'Blogging', ratePerHour: 10) );
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
