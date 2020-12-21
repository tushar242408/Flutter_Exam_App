import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/buttons.dart';
import 'package:brainstorm/widgets/header.dart';
import 'package:brainstorm/widgets/imageshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../signin.dart';
import 'Dashboard.dart';
import 'EditProfile.dart';
import 'SingUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  reg r=new reg();
  bool check=false;

  String _name,_password;
  Widget form({String text,Function onchaged}){
 return    TextFormField(
      decoration: InputDecoration(
          labelText: text
      ),
      onChanged: onchaged,
    );
}
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
              head(),
              Column(
                children: [
                  SizedBox(height: w*4,),
                  Textshow(text:"Sign in",FontSize: w*5,),
                  form(text:"Enter user name",onchaged:((value){
                    _name = value;
                  })),
                  form(text:"Password",onchaged:(value){
                    _password = value;
                  }),
                  SizedBox(height: w*15,),
                  button(text:check?"Please wait...":"LOGIN",width: w*90,height:w*10,txtcolor: Colors.white,ontap:()async{
                    check=true;
                    setState(() {});
                   var  c=await r.singIn(_name,_password);
                   if (c!=null)
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(user:c),),);
                   else{check=false;
                   setState(() {});
                     AlertDialog dialog=AlertDialog(
                       content: new Text("wrong input re input again"),
                     );
                     showDialog(context:context,child:dialog);
                   }
                  },),
                  SizedBox(height: w*5,),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: null),Textshow(text: "Remember Me",color: Colors.grey,FontSize: w*4),
                          SizedBox(width: w*18,),
                      Textshow(text: "Forgot password?",color: Colors.grey,FontSize: w*4),
                    ],
                  ),

                  SizedBox(height: w*8,),  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      imageshow(Imageurl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/368px-Google_2015_logo.svg.png",height: w*10,width: w*30,ontap:()async{
                        check=true;
                        setState(() {

                        });
                        var a=await r.googlr();
                        final DocumentReference documentReference= FirebaseFirestore.instance.collection("Userdata").doc(a);
                        print(documentReference.path);
                         DocumentSnapshot   b=await documentReference.get();
                         var c=b.data()??"yes";
                         if(c=="yes"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfile(uid:a,m: Mydata(),),),);
                         }
                         else{
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(user:a,),),);
                         }

                      }),
                      imageshow(Imageurl: "https://logodownload.org/wp-content/uploads/2014/09/facebook-logo-1-1.png",height: w*10,width: w*30,ontap:(){
                        AlertDialog dialog=AlertDialog(
                          content: new Text("sryy this field is under counstruction"),
                        );
                        showDialog(context:context,child:dialog);
                      }),
                    ],
                  ), SizedBox(height: w*12,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textshow(text: "Dont't have an account?",color: Colors.grey,FontSize: w*3),
                      Textshow(text: "Sing Up",color: Colors.black,FontSize: w*4,ontap:(){
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                           SingUp(),
                        ),
                        );
                      },),
                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
