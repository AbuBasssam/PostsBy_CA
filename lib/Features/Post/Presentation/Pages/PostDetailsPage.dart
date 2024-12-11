import 'package:flutter/material.dart';
import 'package:post_ca/Features/Post/Presentation/Widgets/PostDetails/PostDetailsWidget.dart';

import '../../Domain/Entities/Post.dart';

class Postdetailspage extends StatelessWidget {
  final Post post;
  const Postdetailspage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: _buildAppBar(),
     body:_buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar
    (
      title: Text("Post Details"),
    );
  }

  Widget _buildBody()
  {
    return Center
    (
      child: Padding
      (
        padding: const EdgeInsets.all(10),
        child: PostDetailswidget(post: post),
      ),
    );
 }




}

