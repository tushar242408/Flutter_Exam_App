import 'package:brainstorm/Model/Exam.dart';
import 'package:brainstorm/widgets/TestView.dart';
import 'package:flutter/material.dart';
class Assignedtest extends StatelessWidget {
  List<Exam> data = new List<Exam>();
  Assignedtest({this.data});
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
                return TestView(e:data[index]);
              }),
        ),

      ),
    );
  }
}
