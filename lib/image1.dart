import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/show_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class image1 extends StatefulWidget {
  const image1({super.key});

  @override
  State<image1> createState() => _image1State();
}

class _image1State extends State<image1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imageBody(),
    );
  }
}
class imageBody extends StatefulWidget {
  const imageBody({super.key});

  @override
  State<imageBody> createState() => _imageBodyState();
}

class _imageBodyState extends State<imageBody> {
  @override
  File? profilePic;
  String? downloadUrl;
  bool progress= false;

  Future uploadImage() async{
    setState(() {
      progress = !progress;
    });
    UploadTask uploadTask=FirebaseStorage.instance.ref().child('User-Image').child(Uuid().v1()).putFile(profilePic!);
    TaskSnapshot taskSnapshot=await uploadTask;
    downloadUrl=await taskSnapshot.ref.getDownloadURL();
    addprofileData(imgurl: downloadUrl);

  }
  Future addprofileData({String? imgurl}) async{
    Map<String,dynamic> map2={
      "profileName":profileName.text.toString(),
      "profileUrl":imgurl

    };
    FirebaseFirestore.instance.collection('profile').add(map2);

    setState(() {
      progress = !progress;
    });

    Future.delayed(Duration(milliseconds: 1000));


    Navigator.push(context, MaterialPageRoute(builder: (context) => showImage(),));

  }

  final profileName=TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              XFile? selectedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
              if(selectedImage!=null)
                {
                  File convertedfile=File(selectedImage.path);
                  setState(() {
                    profilePic=convertedfile;
                  });

                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image select')));
                }



            },
            child: CircleAvatar(
              radius: 100,
              // backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/256/209/209818.png'),
              backgroundColor: Colors.blue,
              backgroundImage: profilePic!=null?FileImage(profilePic!):null,

            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
    controller: profileName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Profile Name')
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () async{
            uploadImage();

    }, child: progress==false?Text('Profile Insert'):CircularProgressIndicator())
        ],
      ),
    );
  }
}

