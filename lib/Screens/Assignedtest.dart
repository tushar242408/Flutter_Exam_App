import 'package:brainstorm/Model/Exam.dart';
import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/widgets/TestView.dart';
import 'package:flutter/material.dart';

import 'exmdetails.dart';
class Assignedtest extends StatelessWidget {
  List<Exam> data = new List<Exam>();
  Mydata mydata=Mydata();
  Assignedtest({this.data,this.mydata});
  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: ListView.builder(
            shrinkWrap: true,

scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context,index){
                return TestView(e:data[index],ontap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => detail(data[data.length-1],mydata.giventest,mydata.assigntest[data.length-1])));

                });
              }),
        ),

      ),
    );
  }
}
