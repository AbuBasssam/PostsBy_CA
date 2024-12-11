import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_ca/Core/networks/networkInfo.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/INetworkInfo.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPLocalDataSource.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPRemoteDataSource.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPostRepository.dart';
import 'package:post_ca/Features/Post/Domain/UseCases/PostUseCase.dart';
import 'package:post_ca/Features/Post/Infrastructure/Implementations/DataSource/post_local_data_soutce.dart';
import 'package:post_ca/Features/Post/Infrastructure/Implementations/DataSource/post_remote_data_soutce.dart';
import 'package:post_ca/Features/Post/Infrastructure/Implementations/Repositories/PostRepository.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/CommandsPostBloc/post_commands_bloc_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/QueriesPostBloc/post_request_bloc_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


// final sl = GetIt.instance;

// Future<void> init() async {
// //! Features - posts

// // Bloc

//   sl.registerFactory(() => PostRequestBlocBloc(cases: sl()));
//   sl.registerFactory(()=>PostCommandsBlocBloc(cases: sl()));


// // Usecases
// sl.resetLazySingleton(instance: () => PostUseCase(repo: sl<IPostRepository>()));

//   sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
//   sl.registerLazySingleton(() => AddPostUsecase(sl()));
//   sl.registerLazySingleton(() => DeletePostUsecase(sl()));
//   sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

// // Repository

//   sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// // Datasources

//   sl.registerLazySingleton<PostRemoteDataSource>(
//       () => PostRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<PostLocalDataSource>(
//       () => PostLocalDataSourceImpl(sharedPreferences: sl()));

// //! Core

//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// //! External


//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
// }






final sl = GetIt.instance;
Future<void> Init()async
{
  ///Features - Posts
  
  //Block
  sl.registerFactory(()=>PostRequestBloc(cases: sl()));
  sl.registerFactory(()=>PostCommandsBloc(cases: sl()));

  
  
  
  //UseCase
sl.registerLazySingleton(() => PostUseCase(repo: sl<IPostRepository>()));

  //Repositories

  sl.registerLazySingleton
  (
     ()=> 
    PostRepository
    (
      remoteDataSource:sl<IPRemoteDataSource>(),
      localDataSource:sl<IPLocalDataSource>(),
      networkInfo:sl<INetworkInfo>()
    )
  );
  sl.registerLazySingleton<IPostRepository>(() => PostRepository(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  

  //DataSource
  sl.registerLazySingleton<IPRemoteDataSource>(() => PRemoteDataSource(client: sl()));
  sl.registerLazySingleton<IPLocalDataSource>(() => PLocalDataSource(sharedPreferences: sl()));

  
  ///Core
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(connectionChecker:  sl()));

  ///External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());
}