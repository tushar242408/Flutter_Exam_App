import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/Screens/Dashboard.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/buttons.dart';
import 'package:brainstorm/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../signin.dart';
import 'EditProfile.dart';
import 'login.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  String _fname,_password,_Email,_lname,_collge;
  int _phoneno;
  bool check=false;

  SignUp()async{
    Map<String, dynamic> l={
      "fname":_fname,
      "_lname":_lname,
      "Email":_Email,
      "phone":_phoneno,
      "college":_collge,
      "giventest":[],
      "test":[],
      "assignedtest":["j8AZuejY3htVE5jDMSe1"],
      "Friend":[],
      "bookmark":[],
    };
    print(l);
    reg r=new reg();
   var user=await r.singup(_Email,_password);

   print(user);


    final DocumentReference documentReference= FirebaseFirestore.instance.collection("Userdata").doc(user);
    await documentReference.set(l).whenComplete(() => print("done"));
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>
            Dashboard(user: user)));



  }



  Widget form({String text,Function onchaged}){
    return    TextFormField(
      decoration: InputDecoration(
          labelText: text,
              hintText: "Enter ${text}"
      ),
      onChanged: onchaged,
    );
  }
  @override
  void initState() {
    print(_fname==null);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var  w=MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            head(),
            form(text:"First name",onchaged:((value){
              _fname = value;
            })),
            form(text:"Last Name",onchaged:(value){
              _lname = value;
            }),
            form(text:"Phone Number",onchaged:(value){
              _phoneno = int.parse(value);
            }),
            form(text:"College",onchaged:(value){
              _collge = value;
            }),
            form(text:"Email Address",onchaged:(value){
              _Email = value;
            }),
            form(text:"Password",onchaged:(value){
              _password = value;
            }),
            SizedBox(height: w*10,),
            button(text:check?"Please wait...":"SING UP",width: w*90,height:w*10,txtcolor: Colors.white,ontap:(){

              if(_fname==null || _collge==null || _lname==null || _Email==null ||_password==null || _phoneno==null){
                AlertDialog dialog=AlertDialog(
                  content: new Text("Please input in all field"),
                );
                showDialog(context:context,child:dialog);
              }
              else{
                check=true;
                setState(() {
                });
                SignUp();
              }




            },),
            SizedBox(height: w*10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Textshow(text: "Dont't have an account?",color: Colors.grey,FontSize: w*3),
                Textshow(text: "Sing In",color: Colors.black,FontSize: w*4,ontap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Login(),
                    ),
                  );
                },),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
