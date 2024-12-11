import 'package:flutter/material.dart';
import '../../../Domain/Entities/Post.dart';
import '../../Pages/PostCommandPage.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon
    (
      onPressed: ()
       {
        Navigator.push
            (
              context,
              MaterialPageRoute(
              builder: (_) => Postcommandpage(IsUpdated: true,post: post),)
            );
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}