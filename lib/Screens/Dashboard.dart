import 'package:brainstorm/Model/Exam.dart';
//import 'file:///C:/Users/Tushar/AndroidStudioProjects/brainstorm/lib/Screens/ExamDetais.dart';
import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/Model/Roundwidget.dart';
import 'package:brainstorm/widgets/TestView.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../signin.dart';
import 'Assignedtest.dart';
import 'EditProfile.dart';
import 'Homemydata.dart';
import 'ResltView.dart';
import 'exmdetails.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  final String user;
  const Dashboard({Key key, this.user}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  Mydata mydata=Mydata();

  @override
  getdata()async {
    final DocumentReference documentReference= FirebaseFirestore.instance.collection("Userdata").doc(widget.user.toString());
    var a=await documentReference.get();
    mydata.fname=a.data()["fname"];
    mydata.lname=a.data()["lname"];
    mydata.Colleagename=a.data()["college"];
    mydata.phoneno=a.data()['phone'];
    mydata.assigntest=await a.data()["assignedtest"];
    mydata.Gender=a.data()["gender"];
    mydata.giventest=await a.data()["giventest"];
    mydata.educationQual=a.data()["qualification"];
    mydata.test= await a.data()['test'];
    getexamdata(d:mydata.assigntest);
    print(mydata);
    setState(() {});
  }
  List<Exam> data = new List<Exam>();

  getexamdata({List<dynamic> d})async {
    for (int i = 0; i <d.length; i++) {
      final DocumentReference documentReference = FirebaseFirestore.instance.collection(
          "teachersdata").doc(d[0].toString());
      Exam e=new Exam();
      var a = await documentReference.get();
      e.teachername=a.data()['teachername'];
      e.testname=a.data()['testname'];
      e.date=a.data()['Date'];
      e.level=a.data()['level'];
      e.topic=await a.data()['topic'];
      e.tid=a.data()['tid'];
      data.add(e);
      print(data);
    }

    setState(() {

    });

  }
  void initState() {

    print(widget.user);
    getdata();
    // TODO: implement initState
  }
  BoxDecoration Boxdecor({Color col=Colors.black,}) {
    return BoxDecoration(
        color: col,
        borderRadius: BorderRadius.circular(10)
    );
  }

  @override
  Widget build(BuildContext context) {

    var w=MediaQuery.of(context).size.width/100;
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(

              body: data.length==0?Center(child: CircularProgressIndicator()):SafeArea(
                child: SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(

                       children: [

                            Row(mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               IconButton(icon: Icon(Icons.list),onPressed: ()async{
                                 reg r=new reg();
                             await r.signout();
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => Login()));
                               }),
                               Container(width:w*65,
                                 child: TextField(
                                   decoration: InputDecoration(
                                       hintText: 'Search Name or Test'
                                   ),
                                 ),
                               ),
                               IconButton(icon: Icon(Icons.search))

                             ],
                           ),
                         SizedBox(height: w*12),

                         Center(
                           child: Container(
                             width:w*92,
                             height: w*24,
                             decoration: Boxdecor(col: Colors.lightBlueAccent),
                             child: mine(User:mydata,width:w,onEdit:(){
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                   builder: (context) =>       EditProfile(m:mydata,uid: widget.user.toString(),)));
                             },

                             ),



                           ),
                         ), SizedBox(height: w*5),

                         Textshow(text: "HELLO, ${mydata.fname} ${mydata.lname}",FontSize: w*6.4,),
                         SizedBox(height: w*4),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Box(text:"Exam",color: Colors.deepOrangeAccent,icon: Icon(Icons.sticky_note_2_outlined),ontap: (){
                               Navigator.push(
                                   context,   MaterialPageRoute(
                                   builder: (context) =>     ResultView(mydata.test)      ,));
                             },),
                             Box(text:"Discussion",color: Colors.green,icon: Icon(Icons.cloud),),
                           ],
                         ), SizedBox(height: w*4),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Box(text:"BookMarks",color: Colors.deepPurpleAccent,icon: Icon(Icons.bookmark),),
                             Box(text:"Teachers",color: Colors.redAccent,icon: Icon(Icons.computer_sharp),),
                           ],
                         ), SizedBox(height: w*10),

                         Textshow(text: "Recently Assigned Test" ,FontSize:w*5,ontap: (){
                         },), SizedBox(height: w*4),

                         TestView(e:data[data.length-1],ontap: (){
                          Navigator.push(
                           context,
                             MaterialPageRoute(
                          builder: (context) => detail(data[data.length-1],mydata.giventest,mydata.assigntest[data.length-1])));
                              },),SizedBox(height: w*4),



                         Textshow(text: "Assigned Test" ,FontSize:w*4,ontap: (){
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => Assignedtest(data:data,mydata: mydata,)));
                         },), SizedBox(height: w*4),


                      ],
            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
