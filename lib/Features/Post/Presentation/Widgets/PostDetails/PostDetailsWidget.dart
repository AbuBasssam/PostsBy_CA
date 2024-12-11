import 'package:flutter/material.dart';
import '../../../Domain/Entities/Post.dart';
import 'DeletePostBtnWidget.dart';
import 'UpdatePostBtnWidget.dart';

class PostDetailswidget extends StatelessWidget {
  final Post post;
  const PostDetailswidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return  Padding
    (
      padding: EdgeInsets.all(8),
      child: Column
      (
        children:
         [Text(
            post.Title,
            style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.Body,
            style:const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider( height: 50),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
            [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.Id)
            ],
          )
        ],
      ),
    );
  }
}




