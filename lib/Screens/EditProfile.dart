import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/buttons.dart';
import 'package:brainstorm/widgets/imageshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';
// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  Mydata m=Mydata();
  String uid;
  EditProfile({this.m,this.uid});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _intrested;
  List<String> intrestedlist;
  int phoneno;

  Adddata(){
    final DocumentReference documentReference= FirebaseFirestore.instance.collection("Userdata").doc(widget.uid);
    intrestedlist =_intrested.split(",");
    Map<String, dynamic> l={
      "fname":widget.m.fname,"lname":widget.m.lname,
      "phone":widget.m.phoneno,
      "gender":widget.m.Gender,
      "college":widget.m.Colleagename,
      "qualification":widget.m.educationQual,

    };
    documentReference.set(l, SetOptions(merge: true)).then((value) => print("done"));
    documentReference.set({"intrested":FieldValue.arrayUnion(intrestedlist)}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    Widget form({String text,Function onchaged,key=0,String initial}){
      return    TextFormField(
        initialValue: initial=="null"?"":initial,
        keyboardType: key==0?TextInputType.name:TextInputType.phone,
        decoration: InputDecoration(

            labelText: text
        ),
        onChanged: onchaged,
      );
    }
    var w=MediaQuery.of(context).size.width/100;
    return SafeArea(
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            imageshow(Imageurl: "https://d259t2jj6zp7qm.cloudfront.net/images/20200113132432/quiz-icon-round.png",height: w*20),
            Textshow(text: "Edit Profile",FontSize: w*4,),
              form(text:"Enter First Name",onchaged:((value){
                widget.m.fname = value;
              }),initial: "${widget.m.fname}"),
              form(text:"Enter Last Name",onchaged:((value){
                widget.m.lname = value;
              }),initial: "${widget.m.lname}"),
              form(text:"Enter Phone Number",onchaged:((value){
                widget.m.phoneno = int.parse(value);
              }),key: 1,initial: "${widget.m.phoneno}"),
              form(text:"Enter Gender",onchaged:((value){
                widget.m.Gender = value;
              }),initial:"${ widget.m.Gender}"),
              form(text:"Enter College Name",onchaged:((value){
                widget.m.Colleagename = value;
              }),initial:"${widget.m.Colleagename}"),

              form(text:"Enter qualification",onchaged:((value){
                widget.m.educationQual = value;
              }),initial: "${widget.m.educationQual}"),

              form(text:"Enter Intrested seprate by (,)",onchaged:((value){
                _intrested = value;
              }),),
              SizedBox(height: w*10,),
              button(text:"Add",width: w*50,height:w*10,txtcolor: Colors.white,ontap:()async{
                Adddata();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Dashboard(user:widget.uid )));

              },),
          ],),
        ),
      ),
    );
  }
}
