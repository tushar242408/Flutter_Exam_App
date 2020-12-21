import 'package:flutter/material.dart';

import 'imageshow.dart';

class head extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var  w=MediaQuery.of(context).size.width/100;
    return Stack(
      children: [
        Positioned(
            child:
            Container(height: w*45,width: w*100,
              color: Colors.deepOrangeAccent,
            )),
        Positioned(
          right: 10,
          child:imageshow(Imageurl: "https://cdn4.iconfinder.com/data/icons/project-document-std-pack-3/512/edit_tasks-512.png",height: w*40),
        ),
        Positioned(
          top: 20,
          left: 10,
          child:imageshow(Imageurl: "https://d259t2jj6zp7qm.cloudfront.net/images/20200113132432/quiz-icon-round.png",height: w*20),
        ),

      ],
    );
  }
}
