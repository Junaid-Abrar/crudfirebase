import 'package:achievement_view/achievement_view.dart';
import 'package:crudfirebase/edit.dart';
import 'package:crudfirebase/image.dart';
import 'package:crudfirebase/image1.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myApp());
}
class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: image1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class myHome extends StatefulWidget {
  const myHome({super.key});

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(),
    );
  }
}
class myBody extends StatefulWidget {
  const myBody({super.key});

  @override
  State<myBody> createState() => _myBodyState();
}

class _myBodyState extends State<myBody> {
  @override
  final firstname=TextEditingController();
  final lastname=TextEditingController();
  final email=TextEditingController();
  String selectedGender='Male';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();

  }

  Future addData() async{
    Map<String,dynamic> map1={
      'firstname':firstname.text.toString(),
      'lastname':lastname.text.toString(),
      'email':email.text.toString(),
      'gender':selectedGender
    };
    firstname.clear();
    lastname.clear();
    email.clear();
    await FirebaseFirestore.instance.collection("Users").add(map1);
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Insert',style: TextStyle(
               color: Colors.purple,
               fontSize: 30
             ),),
             SizedBox(height: 20,),
             TextFormField(
               controller: firstname,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 label: Text("First Name"),
                 hintText: "Enter your first name"
               ),
             ),
          SizedBox(height: 20,),
             TextFormField(
               controller: lastname,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   label: Text("Last Name"),
                   hintText: "Enter your last name"
               ),
             ),

             SizedBox(height: 20,),
             TextFormField(
               controller: email,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   label: Text("Email"),
                   hintText: "Enter your email"
               ),
             ),
             SizedBox(height: 20,),
             DropdownButtonFormField(
             value: selectedGender,
             onChanged: (newValue){
               setState(() {
                 selectedGender=newValue!;
               });
             },
              items: ['Male','Female','Other'].map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem(child: Text(value),
                value: value,
                );
              }).toList(),
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 fillColor: Colors.white,
                 filled: true
               ),
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
                   addData();
                   AchievementView(
                     title: "Data Insert",
                     subTitle: "Successfully",
                     color: Colors.green
                   )..show(context);
                 },
                 child: Text('Insert'),
               ),
             ),
             StreamBuilder(stream: FirebaseFirestore.instance.collection('Users').snapshots(), builder: (context, snapshot) {
               return ListView.builder(
                 shrinkWrap: true,
                 itemCount: snapshot.data!.docs.length,
                 itemBuilder: (context, index) {
                   var userId=snapshot.data!.docs[index].id;
                   var fname=snapshot.data!.docs[index]['firstname'];
                   var lname=snapshot.data!.docs[index]['lastname'];
                   var email=snapshot.data!.docs[index]['email'];

                 return Card(
                   child: Container(
                     margin: EdgeInsets.symmetric(vertical: 10),
                     child: Column(
                       children: [
                         Text(snapshot.data!.docs[index]['firstname']),
                         Text(snapshot.data!.docs[index]['lastname']),
                         Text(snapshot.data!.docs[index]['gender']),
                         Text(snapshot.data!.docs[index]['email']),
                         SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             ElevatedButton(onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => edit(id: userId, fname: fname, lname: lname, email: email,gender: selectedGender),));
                             }, child: Text('Edit')),
                             SizedBox(width: 20,),
                             ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: Colors.red
                                 ),
                                 onPressed: () async{
                                   await FirebaseFirestore.instance.collection('Users').doc(userId).delete();
                                   AchievementView(
                                     title: "Data delete",
                                     color: Colors.red,
                                     icon: Icon(Icons.delete)
                                   )..show(context);

                                 }, child: Text('Delete'))
                           ],
                         )

                       ],
                     ),
                   ),
                 );
               },);
             },)

           ],
         ),
        ),
      ),
    );
  }
}


