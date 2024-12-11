import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_ca/Core/Themes/app_theme.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/CommandsPostBloc/post_commands_bloc_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/QueriesPostBloc/post_request_bloc_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Pages/PostsPage.dart';
import 'InjectionContainer.dart'as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.Init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider
    (
        providers:
        [
          BlocProvider
          (
              create: (_) => di.sl<PostRequestBloc>()..add(GetAllPostsEvent())),
              BlocProvider(create: (_) => di.sl<PostCommandsBloc>()
          ),
        ],
        child: MaterialApp
        (
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          title: 'Posts App',
          home: PostsPage()
        )
      
      );
  }
  
}
