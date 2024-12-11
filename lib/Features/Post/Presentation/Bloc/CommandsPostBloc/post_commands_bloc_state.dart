part of 'post_commands_bloc_bloc.dart';

sealed class PostCommandsBlocState extends Equatable
{
  const PostCommandsBlocState();
  
  @override
  List<Object> get props => [];
}

final class PostCommandsBlocInitial extends PostCommandsBlocState {}
class AddDeleteUpdatePostInitial extends PostCommandsBlocState {}


class LoadingCommandsPostState extends PostCommandsBlocState {}

class ErrorCommandsPostState extends PostCommandsBlocState 
{
  final String message;

  ErrorCommandsPostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageCommandsPostState extends PostCommandsBlocState
{
  final String message;

  MessageCommandsPostState({required this.message});

  @override
  List<Object> get props => [message];
}