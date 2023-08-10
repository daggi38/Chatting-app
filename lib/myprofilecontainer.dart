import 'package:flutter/material.dart';

class Myprofilecontainer extends StatefulWidget {
  final email;
  final username;
  final bio;
  void Function()? onTap;
  void Function()? upload;
  void Function()? edituser;

  Myprofilecontainer(
      {super.key,
      required this.email,
      required this.username,
      required this.bio,
      required this.onTap,
      required this.upload,
      required this.edituser});

  @override
  State<Myprofilecontainer> createState() => _MyprofilecontainerState();
}

class _MyprofilecontainerState extends State<Myprofilecontainer> {
  bool isenlarged = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       isenlarged = !isenlarged;
            //     });
            //   },

            //   child: CircleAvatar(
            //     backgroundColor: Colors.grey[300],
            //     radius: isenlarged ? 200 : 50,
            //     backgroundImage: widget.image.image,
            //   ),
            // ),

            TextButton(
                onPressed: widget.upload,
                child: Text(
                  'Upload Profile Picture',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Text(
              'Email ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Text(
              widget.email,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Username ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  widget.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: widget.edituser, icon: Icon(Icons.edit)),
              ],
            ),

            Row(
              children: [
                Text(
                  "Bio ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.bio,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                IconButton(onPressed: widget.onTap, icon: Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
