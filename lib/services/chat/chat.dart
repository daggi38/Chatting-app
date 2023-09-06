import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:mychat/models/messages.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendmessage(String recevierid, String message) async {
    final String currentuserid = _firebaseAuth.currentUser!.uid;
    final String currentuseremail =
        _firebaseAuth.currentUser!.email!.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(
        senderid: currentuserid,
        senderemail: currentuseremail,
        recevierid: recevierid,
        message: message,
        timestamp: timestamp);
        List<String> ids = [currentuserid, recevierid];
    ids.sort();

    String chatroomid = ids.join("_");
    await _firebaseFirestore
        .collection("chat-rooms")
        .doc(chatroomid)
        .collection("chats")
        .add(newmessage.toMap());
  }


  
Future<void> deletepost(String userid, otherid ) async {
  List<String> ids = [userid, otherid];
    ids.sort();
    String chatroomid = ids.join("_");
    
    await FirebaseFirestore.instance
        .collection('chat-rooms')
        .doc(chatroomid)
        .collection('chats')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
  Future<void>updatechat(String userid, otherid, docid, String message) async {
    List<String> ids = [userid, otherid];
    ids.sort();
    String chatroomid = ids.join("_");

    await _firebaseFirestore
        .collection("chat-rooms")
        .doc(chatroomid)
        .collection('chats')
        .doc(docid)
        .update({"message": message});
  }

  

  Future<void>deletechat(String userid, otherid, docid) async {
    List<String> ids = [userid, otherid];
    ids.sort();
    String chatroomid = ids.join("_");

    await _firebaseFirestore
        .collection("chat-rooms")
        .doc(chatroomid)
        .collection('chats')
        .doc(docid)
        .delete();
  }

  Stream<QuerySnapshot> getmessages(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join("_");
    return _firebaseFirestore
        .collection("chat-rooms")
        .doc(chatroomid)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

