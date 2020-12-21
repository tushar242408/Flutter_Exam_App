import 'dart:async';
import 'package:brainstorm/Screens/login.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:brainstorm/widgets/imageshow.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens/Dashboard.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp()));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer _timer;
  void startTimer(int duration) {
    const onsec= const Duration(seconds:1);
    _timer=new Timer.periodic(
        onsec,(Timer timer){
      if(duration<1){
        _timer.cancel();
        if(user==null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );}
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(user: user.uid,),
            ),
          );

        }

      }
      else{
        duration=duration-1;
      }
    }
    );
  }
  var user;
@override
  void initState() {
 user= FirebaseAuth.instance.currentUser;


startTimer(3);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var w=MediaQuery.of(context).size.width/100;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(

              bottom: 0,
              child:imageshow(Imageurl: "https://thumbs.dreamstime.com/z/abstract-crayon-drawings-white-paper-background-texture-165839511.jpg",height: w*70,),
              ),
          Positioned(
              bottom: w*16,
              right: 0,
              child:imageshow(Imageurl: "https://cdn4.iconfinder.com/data/icons/project-document-std-pack-3/512/edit_tasks-512.png",height: w*50,ontap: ()=>  Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              ),)),
          Positioned(bottom: 0,
              child:
              Container(height: w*10,width: w*100,
                color: Colors.deepOrangeAccent,
              )),
          Positioned(
            top: w*20,
              left: w*10,
              child:
              Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textshow(text: "Hello",FontSize: w*12,),
                    Textshow(text: "Welcome To Exam System",FontSize: w*3.5,color: Colors.grey),
                  ],
                ),

              )),


        ],
      ),

    );
  }
}

