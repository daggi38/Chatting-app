import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/components/chatcontainer.dart';
import 'package:mychat/components/formattime.dart';
import 'package:mychat/components/textfields.dart';
import 'package:mychat/pages/profilepage.dart';
import 'package:mychat/services/chat/chat.dart';
import 'package:provider/provider.dart';

import '../services/obsecure.dart';
class chatpage extends StatefulWidget {
  final String recevieruseremail;
  final String recevierid;

  chatpage(
      {super.key, required this.recevieruseremail, required this.recevierid});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  
  final TextEditingController _messagecontroller = TextEditingController();

  final ChatService _chatService = ChatService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isvisible = true;

  void sendemessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.recevierid, _messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  final _newmessagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
final myscroll = Provider.of<isobsecure>(context);
    
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
              color: Colors.grey[300],
              offset: Offset(5, 5),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                "Are you sure you want to clear chat ",
                                style: TextStyle(color: Colors.red[700]),
                              ),
                              backgroundColor: Colors.grey[200],
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    _chatService.deletepost(widget.recevierid,
                                        _firebaseAuth.currentUser!.uid);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"))
                              ],
                            ),
                          );
                        },
                        child: Text("Clear chat")),
                  ),
                  PopupMenuItem(
                    child: Text("Go to first message"),
                    onTap: () {
                      myscroll.show();
                    },
                  ),
                  PopupMenuDivider(height: 2),
                ];
              })
        ],
        backgroundColor: Color.fromARGB(255, 122, 123, 123),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                        recevierid: widget.recevierid,
                        recevieruseremail: widget.recevieruseremail)));
          },
          child: Text(
            widget.recevieruseremail,
            style: GoogleFonts.abel(fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey[500]!,
                    const Color.fromARGB(255, 39, 38, 38)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: _buildchatlist()),
          ),
          _textbox()
        ],
      ),
    );
  }

  Widget _buildchatlist() {
    final myscroll = Provider.of<isobsecure>(context);
  
    return StreamBuilder(
      stream: _chatService.getmessages(
          widget.recevierid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Text("Loading");
        }
        if (snapshot.data!.docs.length == 0) {
          return Center(
              child: Text("Welcome to My chat start a conversation",
                  style:
                      GoogleFonts.abel(fontSize: 25, color: Colors.grey[300])));
        }

        return ListView(
          reverse: myscroll.showing,
          children: snapshot.data!.docs
              .map((document) => _buildchatlistitem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildchatlistitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var concolor = (data['senderid'] == _firebaseAuth.currentUser!.uid)
        ? Colors.blue[200]
        : Colors.green[200];
    var alignment = (data['senderid'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var newalignment = (data['senderid'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    bool isiconvisible = (data['senderid'] == _firebaseAuth.currentUser!.uid);

    return Container(
        alignment: alignment,
        child: Column(
          children: [
            Chatcontainer(
              onTap: () {
                if ((data['senderid'] == _firebaseAuth.currentUser!.uid)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'Select an option',
                        style: TextStyle(color: Colors.red[700]),
                      ),
                      backgroundColor: Colors.grey[200],
                      actions: [
                        ListTile(
                          onTap: () {
                            {
                              _chatService.deletechat(widget.recevierid,
                                  _firebaseAuth.currentUser!.uid, document.id);
                            }
                            Navigator.pop(context);
                          },
                          title: Text("Delete message"),
                        ),
                        ListTile(
                          title: Text("Edit message"),
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Enter new message",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        controller: _newmessagecontroller,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _chatService.updatechat(
                                                  widget.recevierid,
                                                  _firebaseAuth
                                                      .currentUser!.uid,
                                                  document.id,
                                                  _newmessagecontroller.text);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Edit"))
                                      ],
                                    ));
                          },
                        )
                      ],
                    ),
                  );
                }
              },
              mycolor: concolor,
              message: data['message'],
              thetimestamp: formatdate(data['timestamp']),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }

  Widget _textbox() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: textfields(
                ontap: () {},
                suffixicon: false,
                hinttext: "Enter text",
                obscuretext: false,
                controller: _messagecontroller),
          ),
        ),
        IconButton(
            onPressed: () {
              sendemessage();

              ;
            },
            icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
