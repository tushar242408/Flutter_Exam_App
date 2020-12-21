import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class imageshow extends StatelessWidget {
  final String Imageurl;
  final double width,height,radius;
  final Function ontap;

  const imageshow({Key key, this.Imageurl, this.width, this.height,this.ontap,this.radius=0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,width:width,
        child:CachedNetworkImage(imageUrl:Imageurl),
      ),
    );
  }
}
