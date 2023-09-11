import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class showImage extends StatefulWidget {
  const showImage({super.key});

  @override
  State<showImage> createState() => _showImageState();
}

class _showImageState extends State<showImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('profile').snapshots(),
        builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.hasError)
        {
          return Center(
            child: Text('There are some issue'),
          );
        }
        if(snapshot.hasData)
        {
          var ulenght=snapshot.data!.docs.length;
          return ListView.builder(
            itemCount: ulenght,
            itemBuilder: (context, index) {
              String? name=snapshot.data!.docs[index]['profileName'];
              String? profileImg=snapshot.data!.docs[index]['profileUrl'];
              return Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: profileImg!=null?NetworkImage(profileImg):NetworkImage(''),
                      ),
                    ),
                    SizedBox(width: 10,),
                    name!=null?Text(name):Text(""),
                  ],
                ),
              );
            },);
        }
        return Container();

      },) ,
    );
  }
}
