import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/pages/chatpage.dart';

import 'package:provider/provider.dart';

import '../services/authservices.dart';
import 'myprofilepaage.dart';

class homepage extends StatefulWidget {
  homepage({
    super.key,
  });

  @override
  State<homepage> createState() => _homepageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _homepageState extends State<homepage> {
  String val = '';
  Image? image;
  void signout() {
    final authservice = Provider.of<Authservice>(context, listen: false);

    authservice.signuserOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 122, 123, 123),
          actions: [
            GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: mysearch());
                },
                child: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  signout();
                },
                icon: Icon(Icons.logout))
          ],
          title: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfilePage(
                                recevierid: _auth.currentUser!.uid,
                                recevieruseremail:
                                    _auth.currentUser!.email.toString(),
                              )));
                },
                child: Text(_auth.currentUser!.email.toString(),
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ))),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.group,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.wifi_channel,
                  color: Colors.grey,
                ),
              )
            ]),
            Expanded(
              child: TabBarView(children: [
                Expanded(
                    child: Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height,
                        child: _builduserlist())),
                Container(
                  color: Colors.amber,
                ),
                Container(
                  color: Colors.red,
                )
              ]),
            )
          ],
        ),

        // body: Column(
        //   children: [Text("data"), Expanded(child: _builduserlist())],
        // ),
      ),
    );
  }

  Widget _builduserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => builderuserlistitem(doc))
                .toList(),
          );
        });
  }

  Widget builderuserlistitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      List<String> imageurls = [];

      for (int i = 0; i < data['imageurl'].length; i++)
        imageurls.add(data['imageurl'][i]);

      return Padding(
        padding: const EdgeInsets.only(
          top: 3,
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[600]),
          child: ListTile(
            // leading: ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: CachedNetworkImage(
            //     height: 50,
            //     width: 50,
            //     imageUrl: imageurls[0],
            //   ),
            // ),
            title: Text(data['email']),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => chatpage(
                            recevieruseremail: data['email'],
                            recevierid: data['uid'],
                          )));
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

// ignore: camel_case_types
class mysearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _builduserlist();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _builduserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('email'.toString(), isGreaterThanOrEqualTo: query.toString())
            .where('email'.toString(),
                isLessThanOrEqualTo: query.toString() + '\uf8ff')

            // explain the above code

            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => builderuserlistitem(doc, context))
                .toList(),
          );
        });
  }

  Widget builderuserlistitem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
        child: ListTile(
          tileColor: Colors.grey[100],
          leading: CircleAvatar(
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Text(data['email'][0]),
          ),
          title: Text(data['email']),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chatpage(
                          recevieruseremail: data['email'],
                          recevierid: data['uid'],
                        )));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
