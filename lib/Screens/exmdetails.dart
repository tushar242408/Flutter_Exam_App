import 'package:brainstorm/Model/Exam.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'attemptexam.dart';
class detail extends StatefulWidget {
  final  e,id;
  List<dynamic> b=List<dynamic>();

  detail(this.e,this.b,this.id);
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  Map color={
    "1":Colors.pinkAccent,"2":Colors.blueAccent,"3":Colors.orange
  };
  bool attemp;
  String selctsection;
List<String> section=['About','Topic Covered','Resource material','Friend attempt'];



  Map<String, dynamic> about=Map<String, dynamic>();
getdataabout() async {
  final DocumentReference documentReference = FirebaseFirestore.instance.collection(
      "teachersdata").doc(widget.id);
  var a = await documentReference.get();
  about=a.data()['${selctsection.toLowerCase()}'];
  print (about.length);
  setState(() {

  });
}
  @override
  void initState() {
  getdataabout();

    selctsection=section[0];
    attemp=widget.b.contains(widget.e.tid);



    // TODO: implement initState
    super.initState();
  }

  @override

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: w*80,
                width: w*100,
                decoration: BoxDecoration(
                  color: color["${widget.e.level}"],
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) )
                ),),
              Positioned(
                top: w*10,
                right: w*5,
                child: IconButton(icon: Icon(Icons.bookmark,color: Colors.white,), onPressed: null) ,
              ),
              Positioned(
                top: w*10,
                right: w*18,
                child: IconButton(icon: Icon(Icons.share_outlined,color: Colors.white,), onPressed: null) ,
              ),
              Positioned(
                top: w*10,
                left: w*5,
                child: IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,), onPressed:(){
                  Navigator.pop(context);

                }) ,
              ),
              Positioned(
                bottom: w*10,
                left: w*10,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textshow(text: "${widget.e.testname}",color: Colors.white,FontSize: w*9,),
                Textshow(text: "${widget.e.teachername}",color: Colors.white,FontSize: w*5,),

                    ],
                  ),


),
            ],
          ),SizedBox(height: w*20,),
    Container(
    height: w * 5.5,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: section.length,
    itemBuilder: (context, index) {
    return GestureDetector(
    child: Container(
    margin: EdgeInsets.symmetric(
    horizontal: w * 3),
    child: Textshow(text:section[index],color: selctsection==section[index]?Colors.orange:Colors.black,),

      ),
    onTap:(){
      selctsection=section[index];
      setState(() {
        about=Map<String, dynamic>();
        getdataabout();

      });
    }

    );
    },
    ),
    ),
          SizedBox(height: w*6,),

about.length!=0?Column(
  children: [
    Row(
      children: [
        IconButton(icon: Icon(Icons.timelapse_outlined), onPressed: null),
        Textshow(text:"  ${about['date']}",color:Colors.black,),
      ],
    ),
    SizedBox(height: w*5,),
    Row(
      children: [
        IconButton(icon: Icon(Icons.description), onPressed: null),
        Container(
            width:w*80,child: Textshow(text:"  ${about['description']}",color:Colors.black,)),
      ],
    ),
  ],
):Container(
  child: Textshow(text:"no data available",color:Colors.black,),
),
          SizedBox(height: w*6,),
          Row(
            children: [ SizedBox(width: w*6,),
              Textshow(text:attemp?"\$":"?",color:Colors.blueAccent,FontSize: w*9,),
              SizedBox(width: w*3,),
              Column(
                children: [
                  Textshow(text:"your score",color:Colors.black,FontSize: w*5,),
                  Textshow(text:attemp?"Already attempt check score in exam":"Not Attemptexam",color:Colors.grey,),
                ],
              ),
            ],
          ),






          SizedBox(height: w*20,),
          button(text: attemp?"REATTEMPT  EXAM":"ATTEMPT EXAM",width: w*50,txtcolor: Colors.white,height: w*10,ontap:(){   Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Attemptexam(widget.e.tid)));
  },)
        ],
      ),
    );
  }
}
