import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class edit extends StatefulWidget {
  var id;
  var fname;
  var lname;
  var email;
  var gender;


  edit({required this.id,required this.fname,required this.lname,required this.email,required this.gender});
  @override
  State<edit> createState() => _editState(id1: id);
}

class _editState extends State<edit> {
  var id1;

  _editState({required this.id1});

  @override
  void initState() {
    // TODO: implement initState
    fname.text=widget.fname;
    lname.text=widget.fname;
    email.text=widget.email;
    selectedGender=widget.gender;
    super.initState();
  }
  String selectedGender='Male';
  final fname=TextEditingController();
  final lname=TextEditingController();
  final email=TextEditingController();
  Future updateData() async{
    await FirebaseFirestore.instance.collection('Users').doc(id1).update(
      {
        'firstname':fname.text.toString(),
        'lastname':lname.text.toString(),
        'gender':selectedGender,
        'email':email.text.toString()
      }


    );
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Edit Data',style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30
              ),),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: fname,
                decoration: InputDecoration(
                  label: Text('First Name'),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: "Enter Your First Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: lname,
                decoration: InputDecoration(
                  label: Text('Last Name'),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: "Enter Your Last Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  label: Text('Email'),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: "Enter Your Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15,),
              DropdownButtonFormField(
                value: selectedGender,
                onChanged: (newValue){
                  setState(() {
                    selectedGender=newValue!;
                  });
                },
                items: ['Male','Female','Other'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(child: Text(value),value: value,);
                }).toList(),
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple
                  ),
                onPressed: (){
                    updateData();
                },
                child: Text('Edit Data'),
              ),)


            ],
          ),
        ),
      ),
    );
  }
}

