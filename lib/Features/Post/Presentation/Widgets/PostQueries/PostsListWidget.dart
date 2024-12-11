import 'package:flutter/material.dart';
import 'package:post_ca/Features/Post/Presentation/Pages/PostDetailsPage.dart';

import '../../../Domain/Entities/Post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post>posts;
   PostsListWidget({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated
    (
      itemBuilder: (context,index)
      {
       return  ListTile
        (
          leading:Text( posts[index].Id.toString()),
          title:Text( posts[index].Title,style:const TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
          subtitle:Text( posts[index].Body,style:const TextStyle(fontSize: 16)),
          contentPadding: const EdgeInsets.symmetric(horizontal:  10),
          onTap: ()=>
          {
            Navigator.push(context,MaterialPageRoute(builder: (_)=>Postdetailspage(post:posts[index])))
          },
        );

      },
      
      separatorBuilder: (context,index)=>const Divider(thickness: 1),
      itemCount: posts.length
    );
  }
}