part of 'post_commands_bloc_bloc.dart';

sealed class PostCommandsBlocEvent extends Equatable {
  const PostCommandsBlocEvent();

  @override
  List<Object> get props => [];
}
class AddPostEvent extends PostCommandsBlocEvent {
  final PostDTO post;

   AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends PostCommandsBlocEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends PostCommandsBlocEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}