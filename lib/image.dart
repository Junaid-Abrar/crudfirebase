import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class image extends StatefulWidget {
  const image({super.key});

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {

  File? profilepic;
  String? imageDownloadURL;

  Future imageUpload()async{
    UploadTask uploadTask = FirebaseStorage.instance.ref().child("User-Image").child(Uuid().v1()).putFile(profilepic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    imageDownloadURL = await taskSnapshot.ref.getDownloadURL();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Center(
            child: GestureDetector(
              onTap: ()async{
                XFile? selectimage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (selectimage!=null) {
                  File convertedFile = File(selectimage.path);
                  setState(() {
                    profilepic = convertedFile;
                  });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image selected")));
                }
              },
              child: Container(
                width: 200,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  backgroundImage: profilepic!=null?FileImage(profilepic!):null,
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text('Name'),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(

              )
            ),
          )
        ],
      ),
    );
  }
}
