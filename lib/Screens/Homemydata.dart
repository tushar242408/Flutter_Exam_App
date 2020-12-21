import 'package:brainstorm/Model/Myuserdata.dart';
import 'package:brainstorm/widgets/Textshow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class mine extends StatelessWidget {
  Mydata User;
  Function onEdit;
  var width;

 mine({Key key, this.User,this.onEdit,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
              width: width*15,
              height: width*15,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("https://pbs.twimg.com/profile_images/864282616597405701/M-FEJMZ0_400x400.jpg")
                  )
              )),
        ),
        SizedBox(width: width*3,),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Textshow(text: "${User.fname} ${User.lname}",FontSize: width*4,),
          Textshow(text: User.Colleagename,color: Colors.grey,FontSize: width*3.8),]
        ),

        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(
              padding: EdgeInsets.all(width),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: width/5)
              ),
              child: Row(children: [
                Textshow(text: "${User.assigntest.length} Test Asigned")
              ],),
            ),

            Container(
              padding: EdgeInsets.all(width),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: width/5)
              ),
              child: Row(children: [
                Textshow(text: "${0} TeamMates")
              ],),
            ),



          ],
        ),
        IconButton(icon: Icon(Icons.sticky_note_2_rounded),onPressed: onEdit,)

      ],
    );
  }
}


