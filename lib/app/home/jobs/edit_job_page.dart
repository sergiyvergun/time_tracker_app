import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/database.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  final Database database;
  final Job job;

  const EditJobPage({Key key, @required this.database, this.job})
      : super(key: key);

  static Future show(BuildContext context, {Job job}) async {
    final database = context.read<Database>();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (c) => EditJobPage(
        database: database,
        job: job,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  String _name;
  int _ratePerHour;

  @override
  void initState() {
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }

    super.initState();
  }

  _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _submit() async {
    if (_validateAndSaveForm()) {
      setState(() {
        _saving = true;
      });
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((j) => j.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(context,
              title: 'Name already used',
              content: 'Please choose another job name',
              defaultActionText: 'OK');
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate;
          final job = Job(name: _name, ratePerHour: _ratePerHour, id: id);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: 'Operation failed', exception: e);
      }
      setState(() {
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New Job'),
        actions: [
          IconButton(
              onPressed: () => _saving ? null : _submit(),
              icon: Icon(
                Icons.done,
                color: _saving ? Colors.grey : Theme.of(context).primaryColor,
              )),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              EdgeInsets.only(top: 15) + EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: new InputDecoration(
                  label: Text('Name'), icon: Icon(Icons.title)),
              validator: (value) =>
                  value.isNotEmpty ? null : 'Name can\'t be empty',
              onSaved: (String value) => _name = value,
            ),
            Container(height: 16),
            TextFormField(
              initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              onSaved: (String value) =>
                  _ratePerHour = int.tryParse(value) ?? 0,
              decoration: new InputDecoration(
                  label: Text('Rate per hour'), icon: Icon(Icons.attach_money)),
            ),
          ],
        ),
      ),
    );
  }
}
