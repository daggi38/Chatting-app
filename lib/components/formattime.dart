import 'package:cloud_firestore/cloud_firestore.dart';

String formatdate(Timestamp timestamp) {
  DateTime datetime = timestamp.toDate();
  String month = datetime.month.toString();
  String day = datetime.day.toString();
  String hour = datetime.hour.toString();
  String minute = datetime.minute.toString();

  String ampm = datetime.hour > 12 ? 'pm' : 'am';

  String formatteddata = '$hour' + ':' + '$minute' + ' ' + '$ampm';
  return formatteddata;
}
