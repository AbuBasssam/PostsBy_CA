import 'package:dartz/dartz.dart';
import 'package:post_ca/Core/Errors/Failure.dart';
import 'package:post_ca/Features/Post/Domain/Entities/Post.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';

abstract class IPostRepository
{
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(PostDTO post);  
}