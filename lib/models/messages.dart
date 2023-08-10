import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String senderemail;
  final String recevierid;
  final String message;
  final Timestamp timestamp;

  
  Message({required this.senderid,required this.senderemail,required this.recevierid,required this.message,required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'senderid':senderid,
      'senderemail':senderemail,
      'recevierid':recevierid,
      'message':message,
      'timestamp':timestamp,

    };

  }
}
