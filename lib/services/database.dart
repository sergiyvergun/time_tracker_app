import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) =>
      _setData(path: APIPath.job(uid, 'job_abc'), data: job.toMap());

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await documentReference.set(data);
  }
}
