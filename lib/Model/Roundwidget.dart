import 'package:brainstorm/widgets/Textshow.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
 final Color color;
 final Icon icon;
 final String text;
 final Function ontap;

  const Box({Key key, this.color, this.icon, this.text,this.ontap}) : super(key: key);

 BoxDecoration Boxdecor({Color col=Colors.black,}) {
   return BoxDecoration(
       color: col,
       borderRadius: BorderRadius.circular(10)
   );
 }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width/100;
    return GestureDetector(
      onTap: ontap,
      child: Container(
 width: w*40,
        height:w*24,
        decoration: Boxdecor(col: color),
        child:Stack(
          children: [
            Positioned(
              left: 8,
                bottom: 8,
                child: Textshow(text: text,FontSize: w*4),),
            Positioned(
              right: 3,
              top: 3,
              child: IconButton(icon: icon,color: Colors.white,)),

          ],
        ),

      ),
    );
  }
}
