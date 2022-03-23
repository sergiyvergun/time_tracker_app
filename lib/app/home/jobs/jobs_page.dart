import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_app/app/home/jobs/empty_content.dart';
import 'package:time_tracker_app/app/home/jobs/list_item_builder.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';

import 'job_list_tile.dart';

class JobsPage extends StatelessWidget {
  Future<void> _createJob(BuildContext context) async {
    try {
      var database = Provider.of<Database>(context, listen: false);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context),
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
          return ListItemBuilder<Job>(
              snapshot: snapshot,
              itemBuilder: (_, job) {
                return JobListTile(
                  job: job,
                  onTap: () {
                    EditJobPage.show(context, job: job);
                  },
                );
              });
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
