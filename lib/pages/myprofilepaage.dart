import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/services/authservices.dart';

import '../myprofilecontainer.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({
    super.key,
  });

  @override
  State<MyProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  String? newimageurl = '';
  final newnamecontroller = TextEditingController();
  final newusernamecontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 122, 123, 123),
          title: Text('Profile')),
      body: _builduserlist(),
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
    List<String> imageurls = [];

    if (_auth.currentUser!.email == data['email']) {
      for (int i = 0; i < data['imageurl'].length; i++)
        imageurls.add(data['imageurl'][i]);

      imageurls = imageurls.reversed.toList();

      double height = 300;
      return Column(children: [
        Container(
          height: height,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data['imageurl'].length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: imageurls[index],
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              );
              // return Image.network(
              //   imageurls[index],
              //   fit: BoxFit.fitWidth,
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              // );
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Myprofilecontainer(
                edituser: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Edit Profile'),
                            content: TextField(
                              controller: newusernamecontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter your new username'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Authservice().usernameupdate(
                                        _auth.currentUser!.uid,
                                        newusernamecontroller.text);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Edit'))
                            ],
                          ));
                },
                upload: () async {
                  String filename =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referencedirimages = referenceRoot.child('images');
                  Reference referenceimagetoupload =
                      referencedirimages.child(filename);

                  try {
                    await referenceimagetoupload.putFile(File(file!.path));
                    newimageurl = await referenceimagetoupload.getDownloadURL();
                  } on FirebaseException catch (e) {
                    print(e);
                  }
                  print("the image$newimageurl");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Image uploaded successfully")));

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.currentUser!.uid)
                      .update({
                    "imageurl": FieldValue.arrayUnion([newimageurl])
                  });
                },
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Edit Profile'),
                            content: TextField(
                              controller: newnamecontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter your new username'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Authservice().update(_auth.currentUser!.uid,
                                        newnamecontroller.text);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Edit'))
                            ],
                          ));
                },
                email: data['email'],
                username: data['username'],
                bio: data['BIO']))
      ]);
    }
    return Container();
  }
}
