part of 'post_request_bloc_bloc.dart';

sealed class PostRequestBlocEvent extends Equatable {
  const PostRequestBlocEvent();

  @override
  List<Object> get props => [];
}
  class GetAllPostsEvent extends PostRequestBlocEvent{} 
  
  class RefershPostsEvent extends PostRequestBlocEvent{}

