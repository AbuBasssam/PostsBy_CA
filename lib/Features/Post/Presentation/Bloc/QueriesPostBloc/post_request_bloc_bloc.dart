import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_ca/Core/Errors/Failure.dart';
import 'package:post_ca/Core/Strings/failures.dart';
import 'package:post_ca/Features/Post/Domain/Entities/Post.dart';
import 'package:post_ca/Features/Post/Domain/UseCases/PostUseCase.dart';

part 'post_request_bloc_event.dart';
part 'post_request_bloc_state.dart';


class PostRequestBloc extends Bloc<PostRequestBlocEvent, PostRequestBlocState> {
  final PostUseCase cases;
  
  PostRequestBloc({required this.cases}) : super(PostRequestBlocInitial())
 {
    on<PostRequestBlocEvent>
    (
      (event, emit)async 
      {
        if (event is GetAllPostsEvent)
        {
          emit(LoadingPostStatue());

          final failureOrPosts = await cases.getAllPosts();
          
          emit(_mapRespnseToState(failureOrPosts));
        }
        else if (event is RefershPostsEvent)
        {
          emit(LoadingPostStatue());

          final failureOrPosts =await cases.getAllPosts();
          
          emit(_mapRespnseToState(failureOrPosts));
        }
      }
    );

    
  
  }
}
String _mapFailureToMessage(Failure failure)
{
    switch (failure.runtimeType)
   {
      case ServerFailure : return SERVER_FAILURE_MESSAGE;
      
      case EmptyCacheFailure : return EMPTY_CACHE_FAILURE_MESSAGE;
      
      case OfflineFailure: return OFFLINE_FAILURE_MESSAGE;
      
      default: return "Unexpected Error , Please try again later .";
   }
  }
  
PostRequestBlocState _mapRespnseToState(Either<Failure, List<Post>> either)
{
    return either.fold
    (
      (failure) => ErrorPostStatue(Message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostStatue(Posts: posts),
    );
  }