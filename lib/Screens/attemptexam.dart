import 'dart:async';

import 'package:brainstorm/Model/Question.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'Dashboard.dart';

class Attemptexam extends StatefulWidget {
  final id;
  Attemptexam(this.id);

  @override
  _AttemptexamState createState() => _AttemptexamState();
}

class _AttemptexamState extends State<Attemptexam> {
  var user;
  aaddata(){
    Map<String,dynamic> l1={
   "testid":widget.id,
      "correct":correct
    };
    user= FirebaseAuth.instance.currentUser.uid;
    print(user);
    final DocumentReference documentReference1= FirebaseFirestore.instance.collection("Userdata").doc(user);
    documentReference1.set({ "test":  FieldValue.arrayUnion([
      l1
    ]),"giventest":FieldValue.arrayUnion([
    widget.id
    ])}, SetOptions(merge: true));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Dashboard(user:user )));
  }

  int _questionno=1,correct=0;
  bool grow=true,submit=true,cor=false;
  List<Question> q=List<Question>();
  List<int> l=List<int>();
  getQue()async{
    final DocumentReference documentReference= FirebaseFirestore.instance.collection("test").doc(widget.id.toString());
    var a=await documentReference.get();
    for(var i=0;i<a.data()["Question"].length;i++) {
      print(a.data()["Question"][i]["que"]);
      Question qu = Question();
      qu.Que = a.data()["Question"][i]["que"];
      qu.op1=a.data()["Question"][i]["opt1"];
      qu.op2=a.data()["Question"][i]["opt2"];
      qu.op3=a.data()["Question"][i]["opt3"];
      qu.op4=a.data()["Question"][i]["opt4"];
      qu.answer=a.data()["Question"][i]["ans"];
      q.add(qu);
    }
    setState(() {

    });
  }
  correctcheck(String ab){
    if(q[_questionno-1].answer==ab)
      cor=true;
     else
       cor=false;

  }

  Timer _timer;
  int result;
  void startTimer(int duration) {
    const onsec= const Duration(seconds:1);
    _timer=new Timer.periodic(
        onsec,(Timer timer){
      if(duration<1) {
        _timer.cancel();
        aaddata();
      }else{
        duration=duration-1;
        setState(() {
          result=duration;
        });
      }
    }
    );
  }
   ab(String op){
    if(op== q[_questionno-1].selectans)
      return Colors.redAccent;
    else
      return Colors.black;
  }
  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    startTimer(30);
    getQue();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return SafeArea(
      child: Scaffold(
        body:q.length==0?Center(child: CircularProgressIndicator()):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Stack(
        children: [
        Container(
        height: w*40,
          width: w*100,
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) )
          ),),
          Positioned(
            top: w*5,
            right: w*10,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.share_outlined,color: Colors.white,), onPressed: () {
      final RenderBox box = context.findRenderObject();
      Share.share(
      "${q[_questionno-1].Que}",
      sharePositionOrigin:
      box.localToGlobal(Offset.zero) &
      box.size);
      },),
                IconButton(icon: Icon(Icons.bookmark,color: Colors.white,), onPressed: null) ,
              ],
            )),
          Positioned(
            bottom: w*10,
            left: w*6,
            child:Textshow(text: "Question No ${_questionno}          ${result}sec",color: Colors.white,FontSize: w*7,)


          ),

        ]),
            Container(
                padding: EdgeInsets.all(w*5),
                child: Textshow(text: "Que:-  ${q[_questionno-1].Que}",FontSize: w*7,ontap:(){
                  _questionno++;
                  setState(() {

                  });
            },)),
            Container(
              padding: EdgeInsets.all(w*8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textshow(text:"1:- ${q[_questionno-1].op1}",FontSize: w*7.8,color:ab(q[_questionno-1].op1),ontap: (){
                    q[_questionno-1].selectans=q[_questionno-1].op1;
                    correctcheck(q[_questionno-1].op1);
                    if(!l.contains(_questionno-1))   l.add(_questionno-1);
                    setState(() {
                    });
                  },),
                  Textshow(text:"2:- ${q[_questionno-1].op2}",FontSize: w*7.8,color:ab(q[_questionno-1].op2),ontap: (){
                    q[_questionno-1].selectans=q[_questionno-1].op2;
                    correctcheck(q[_questionno-1].op2);
                    if(!l.contains(_questionno-1))   l.add(_questionno-1);
                    setState(() {
                    });
                  },),
                  Textshow(text:"3:- ${q[_questionno-1].op3}",FontSize: w*7.8,color:ab(q[_questionno-1].op3),ontap: (){
                    q[_questionno-1].selectans=q[_questionno-1].op3;
                    correctcheck(q[_questionno-1].op3);
                    if(!l.contains(_questionno-1)) l.add(_questionno-1);
                    setState(() {
                    });
                  },),
                  Textshow(text:"4:- ${q[_questionno-1].op4}",FontSize: w*7.8,color:ab(q[_questionno-1].op4),ontap: (){
                    q[_questionno-1].selectans=q[_questionno-1].op4;
                    correctcheck(q[_questionno-1].op4);
                    if(!l.contains(_questionno-1))
                    l.add(_questionno-1);
                    setState(() {
                    });
                  },),

                ],
              ),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                button(
                  width: w*30,
                  height: w*15,
                  text: "Prev",Col:Colors.redAccent,txtcolor:Colors.white,ontap:(){
                  _questionno--;
                  if(_questionno<1){
                    _questionno++;
                  }
                  if(_questionno<q.length-1){
                    submit=true;
                  }
                  if(cor)
                    correct++;
                  else if(cor && l.contains(_questionno)){
                    correct--;
                  }

                  setState(() {

                  },);
                },),
                button(
                  width: w*30,
                  height: w*15,
                  text: submit?"Next":"SUBMIT",Col:Colors.greenAccent,txtcolor:Colors.white, ontap:(){

                    _questionno++;
                    if(_questionno>q.length){
                      _questionno--;
                    }

                     if(cor)
                       correct++;
                     else if(cor && l.contains(_questionno)){
                       correct--;}
                     cor=false;
                     print (correct);
                    if(submit==false){
                      aaddata();
                    }
                    if(_questionno>q.length-1){
                      submit=false;
                    }
                    else{
                      submit=true;
                    }

                     setState(() {

                  });
                },)
              ]

            ),

            Stack(
              children: [

                Container(
                  padding: EdgeInsets.all(w*4),
                  width: w*100,
                  height:grow? w*30:w*60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(w*8),topLeft: Radius.circular(w*8) )
                  ),
                  child: GridView.builder(
                    scrollDirection: grow?Axis.horizontal:Axis.vertical,
                      shrinkWrap: true,

                      itemCount: q.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:grow?1:5),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            print(index);
                            _questionno=index+1;

                            if(_questionno>q.length-1){
                              submit=false;
                            }
                            else{
                              submit=true;
                            }
                            setState(() {

                            });
                          },
                          child: Container(
                             margin: EdgeInsets.only(top: w*8,left: w*6,bottom: w,),
                              color: _questionno>index?l.contains(index)?Colors.green:Colors.red :l.contains(index)?Colors.green :Colors.grey,
                              child: Center(child: Textshow(text: "${index+1}",color: Colors.white,FontSize:w*7))),
                        );
                      }),
                ),
                Positioned(
                  top: w*1.5,
                  left: w*10,
                  child: GestureDetector(
                    onTap: (){
      grow=!grow;
      setState(() {});
    },

                    child: Container(
                      margin: EdgeInsets.all(w*2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.circular(w*2)
                      ),
                      width: w*70,
                      height: w*3,



                    ),
                  ),
                ),
              ],
            )



          ],
        )
      ),
    );
  }
}
