import 'package:dartz/dartz.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';

abstract class IPRemoteDataSource
{
  Future<List<PostDTO>> getAllPosts();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostDTO post);
  Future<Unit> addPost(PostDTO post);  
  
}