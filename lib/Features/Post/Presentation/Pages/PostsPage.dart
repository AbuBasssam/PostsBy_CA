import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/QueriesPostBloc/post_request_bloc_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Pages/PostCommandPage.dart';

import '../../../../Core/Widgets/LoadingWidget.dart';
import '../Widgets/PostQueries/MessageDisplayWidget.dart';
import '../Widgets/PostQueries/PostsListWidget.dart';

class PostsPage extends StatelessWidget
{
  //  PostsPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold
    (
      appBar:  _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingbtn(context)
    );
  }
  
}

AppBar _buildAppBar() => AppBar(title:const Text('Posts'));

Widget _buildBody()
{
  return Padding
  (
    padding: EdgeInsets.all(10),child: BlocBuilder<PostRequestBloc,PostRequestBlocState>
    (
      builder: (context,state)
      {
        if(state is LoadingPostStatue)          
          return LoadingWidget();

        else if(state is LoadedPostStatue)
          return RefreshIndicator
          (
            onRefresh:()=> _onRefersh(context),
            child: PostsListWidget(posts:state.Posts)
          );
          
        else if (state is ErrorPostStatue)
          return MessageDisplayWidget(message:state.Message);
          
        return LoadingWidget();
      }
    ),

      
  );

}

Widget _buildFloatingbtn(BuildContext context)
{
  return FloatingActionButton
  (
    onPressed: ()
    {
      Navigator.push
      (
        context,  MaterialPageRoute
        (
         builder: (_) =>Postcommandpage(IsUpdated: false)
        )
      );
    },
    child:const Icon(Icons.add)
  );
}
Future<void> _onRefersh(BuildContext context) async{BlocProvider.of<PostRequestBloc>(context).add(RefershPostsEvent());}