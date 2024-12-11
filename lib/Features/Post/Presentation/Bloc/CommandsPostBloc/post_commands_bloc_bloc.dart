import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';

import '../../../../../Core/Errors/Failure.dart';
import '../../../../../Core/Strings/Messages.dart';
import '../../../../../Core/Strings/failures.dart';
import '../../../Domain/Entities/Post.dart';
import '../../../Domain/UseCases/PostUseCase.dart';

part 'post_commands_bloc_event.dart';
part 'post_commands_bloc_state.dart';

class PostCommandsBloc extends Bloc<PostCommandsBlocEvent, PostCommandsBlocState>
{
    final PostUseCase cases;

  PostCommandsBloc({required this.cases}) : super(PostCommandsBlocInitial())
   
  {
    on<PostCommandsBlocEvent>
    (
      (event, emit) async
      {
        if (event is AddPostEvent)
        {
          emit(LoadingCommandsPostState());

         final failureOrDoneMessage = await cases.addPost(event.post);

          emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
        }
        else if (event is UpdatePostEvent)
        {
        emit(LoadingCommandsPostState());

        final failureOrDoneMessage = await cases. updatePost(event.post);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      }
      else if (event is DeletePostEvent)
      {
        emit(LoadingCommandsPostState());

        final failureOrDoneMessage = await cases. deletePost(event.postId);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
      }
   );
  }
    
  PostCommandsBlocState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message)
 {
    return either.fold
    (
      (failure) => ErrorCommandsPostState(message: _mapFailureToMessage(failure)),
      (_)       => MessageCommandsPostState(message: message),
    );
 }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

