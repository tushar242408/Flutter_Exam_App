import 'package:flutter/material.dart';

import 'Textshow.dart';

class button extends StatelessWidget {
  final Function ontap;
  final String text;
  final double height,width;
  // ignore: non_constant_identifier_names
  final Color Col,txtcolor;

  // ignore: non_constant_identifier_names
  const button({Key key, this.ontap,@required this.text, this.height=20, this.width=50, this.Col=Colors.black,this.txtcolor,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
                color: Col,
          ),
              child: Center(child: Textshow(text: text,color:txtcolor,FontSize: width-width*0.9,)),

        ));
  }
}
