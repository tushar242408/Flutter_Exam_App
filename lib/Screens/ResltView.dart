import 'package:brainstorm/widgets/Textshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  List<dynamic> reults=List<dynamic>();
  ResultView(this.reults);
  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  void initState() {
    data();
    print(widget.reults);
    // TODO: implement initState
    super.initState();
  }
  List<String> name=List<String>();
  data()async{
    for(int i=0;i<widget.reults.length;i++){




    var store =await FirebaseFirestore.instance .collection('teachersdata')
        .where('tid', isEqualTo: widget.reults[i]['testid'].toString()).get();
    print(store.docs[i]['testname']);
    name.add(store.docs[i]['testname']);



  }
  setState(() {

  });
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width / 100;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),onPressed: (){
          Navigator.of(context).pop();
        }),
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Textshow(text: "Result",),
        ),


        body:name.length==0?Center(
          child: Container(
            child: Textshow(
              text: "You Didn't give any exam",
              color: Colors.red,
            ),
          ),
        ):Container(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount:name.length,
            itemBuilder: (context,index) {
              return Container(
                padding: EdgeInsets.all(w*10),
                margin: EdgeInsets.all(w*5),
                decoration: BoxDecoration(
                  color:Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: w*90, child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    Textshow(text: "${name[index]} ",),
                    Textshow(text: " ${widget.reults[index]['correct']}"),

                  ],
                ),
              );
            }),
      ) ,),
    );

  }
}
