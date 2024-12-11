part of 'post_request_bloc_bloc.dart';

sealed class PostRequestBlocState extends Equatable
{
  const PostRequestBlocState();
  
  @override
  List<Object> get props => [];
}

final class PostRequestBlocInitial extends PostRequestBlocState {}





class LoadingPostStatue extends PostRequestBlocState
{

}

class LoadedPostStatue extends PostRequestBlocState
{
  final List<Post> Posts;

  LoadedPostStatue({required this.Posts});
  
  @override
  List<Object> get props => [Posts];

}

class ErrorPostStatue extends PostRequestBlocState
{
  final String Message;

  ErrorPostStatue({required this.Message});

  @override
  List<Object> get props => [Message];

}
   


