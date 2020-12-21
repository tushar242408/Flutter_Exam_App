import 'package:brainstorm/Model/Exam.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  Exam e=new Exam();
  Function ontap;

  TestView({this.e,this.ontap});
  String s;
  Map Col={"1":"BEGINNER","2":"INTERMEDIATE","3":"EXPERT"};
  Map color={
    "1":Colors.pinkAccent,"2":Colors.blueAccent,"3":Colors.orange
  };
  void initState() {
    print("hello world!");
    s=Col['${e.level}'];
    print(s);

    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return GestureDetector(
      onTap: ontap,
      child: Container(

        margin: EdgeInsets.all(w*4),
        padding: EdgeInsets.all(w*4),


        decoration:BoxDecoration(
          color:color['${e.level}'],
          borderRadius: BorderRadius.circular(w*4)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Textshow(text: "${e.testname}",color: Colors.white,FontSize:w*5),
                Textshow(text: "${e.teachername}",color: Colors.white,),
              ],
            ),
            SizedBox(height: w*8,),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Textshow(text: "Date:${e.date}",color: Colors.white,FontSize:w*3),
                    Textshow(text: "Based:on:",color: Colors.white,),]),

                    Textshow(text: Col['${e.level}'],color: Colors.white,),

                  ],
                ),


          ],
        ),

      ),
    );
  }
}
