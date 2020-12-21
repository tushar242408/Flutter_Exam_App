import 'package:flutter/material.dart';

class Textshow extends StatelessWidget {
 final String text;
final Function ontap;
 final double FontSize;
 final Color color;

  const Textshow({Key key,@required this.text, this.ontap, this.FontSize,this.color=Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          child: Text(text,style:TextStyle(fontSize: FontSize,fontWeight: FontWeight.bold,color:color)),
        ));
  }
}
