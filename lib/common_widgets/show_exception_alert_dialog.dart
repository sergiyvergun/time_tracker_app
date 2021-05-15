import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
    {@required String title, @required Exception exception}) {
  return showAlertDialog(
    context,
    title: title,
    content: message(exception),
    defaultActionText: 'Ok',
  );
}


String message(Exception exception){
  if(exception is FirebaseException){
    return exception.message;
  }return exception.toString();
}