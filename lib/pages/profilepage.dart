import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mychat/components/profilecontainer.dart';

class ProfilePage extends StatefulWidget {
  final String recevieruseremail;
  final String recevierid;
  ProfilePage(
      {super.key, required this.recevierid, required this.recevieruseremail});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final newnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 122, 123, 123),
          title: Text('Profile')),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.grey[500]!, Colors.grey[900]!],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: _builduserlist())),
        ],
      ),
    );
  }

  Widget _builduserlist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where(
              'email',
            )
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
                .map<Widget>((doc) => builderuserlistitem(doc))
                .toList(),
          );
        });
  }

  Widget builderuserlistitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (widget.recevieruseremail == data['email']) {
      List<String> imageurls = [];

      for (int i = 0; i < data['imageurl'].length; i++)
        imageurls.add(data['imageurl'][i]);

      imageurls = imageurls.reversed.toList();

      return Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: ListView.builder(
            
            scrollDirection: Axis.horizontal,
            itemCount: data['imageurl'].length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: imageurls[index],




 fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,

              );
            },
          ),
        ),
      

        profilecontainer(
            email: data['email'], username: data['username'], bio: data['BIO']),
      ]);
    }
    return Container();
  }
}
