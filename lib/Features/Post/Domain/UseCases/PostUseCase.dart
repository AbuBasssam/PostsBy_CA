import 'package:dartz/dartz.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPostRepository.dart';
import 'package:post_ca/Features/Post/Domain/Entities/Post.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';

import '../../../../Core/Errors/Failure.dart';

class PostUseCase
{
  final IPostRepository repo;

  PostUseCase({required this.repo});

  Future<Either<Failure, List<Post>>> getAllPosts()async
      => await repo.getAllPosts();
  
  Future<Either<Failure, Unit>> addPost(PostDTO post) async
   => await repo.addPost(post);

  Future<Either<Failure, Unit>> deletePost(int id) async 
     => await repo.deletePost(id);
  
  Future<Either<Failure, Unit>> updatePost(Post post)async
      => await repo.updatePost(post);
}