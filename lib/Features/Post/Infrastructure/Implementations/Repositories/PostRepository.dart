import 'package:dartz/dartz.dart';
import 'package:post_ca/Core/Errors/Exceptions.dart';
import 'package:post_ca/Core/Errors/Failure.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/INetworkInfo.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPLocalDataSource.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPRemoteDataSource.dart';
import 'package:post_ca/Features/Post/Domain/Entities/Post.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPostRepository.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';


typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepository implements  IPostRepository
{
  final IPRemoteDataSource remoteDataSource;
  final IPLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  PostRepository({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});
 
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async
  => await networkInfo.isConnected?_fetchRemotePosts(): _fetchLocalPosts();
 
  @override
  Future<Either<Failure, Unit>> addPost(PostDTO post) async
 {
    final PostDTO DTO = PostDTO(Title: post.Title, Body: post.Body);

    return await _getMessage(() {return remoteDataSource.addPost(DTO);});
 }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async
  => await _getMessage(() {return remoteDataSource.deletePost(postId);});

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async
  {
    final PostDTO DTO =PostDTO(Id: post.Id, Title: post.Title, Body: post.Body);

    return await _getMessage(() {return remoteDataSource.updatePost(DTO);});
  }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async
  {
    if (await networkInfo.isConnected)
    {
      try
      {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
        
      }
    }
      
    return Left(OfflineFailure());
      
    
  }

  Future<Either<Failure, List<Post>>> _fetchRemotePosts() async {
     try
    {
      final posts = await remoteDataSource.getAllPosts();
      localDataSource.cachePosts(posts);
      List<Post>remotePosts=[]; 
      for (var post in posts)
       {
         remotePosts.add(Post(Id: post.Id!,Title: post.Title,Body: post.Body));
        
      }
      return Right(remotePosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Post>>> _fetchLocalPosts() async {
    try {
      final posts = await localDataSource.getCachedPosts();
      
      List<Post>localPosts=[]; 
      for (var post in posts)
        {
         localPosts.add(Post(Id: post.Id!,Title: post.Title,Body: post.Body));
        }
      return Right(localPosts);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

}