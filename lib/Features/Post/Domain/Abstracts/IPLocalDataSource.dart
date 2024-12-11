import 'package:dartz/dartz.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';

abstract class IPLocalDataSource
{
   Future<List<PostDTO>> getCachedPosts();
  Future<Unit> cachePosts(List<PostDTO> postModels);
  
}
