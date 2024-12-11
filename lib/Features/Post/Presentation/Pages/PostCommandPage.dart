import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_ca/Core/Util/SnackBarMessages.dart';
import 'package:post_ca/Core/Widgets/LoadingWidget.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/CommandsPostBloc/post_commands_bloc_bloc.dart';
import 'package:post_ca/Features/Post/Presentation/Pages/PostsPage.dart';

import '../../Domain/Entities/Post.dart';
import '../Widgets/PostCommands/FormWidget.dart';

class Postcommandpage extends StatelessWidget {
 final Post? post;
 final bool IsUpdated;
 Postcommandpage({super.key,this.post,required this.IsUpdated});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar:_buildAppBar(),
      body: _buildBody(),
    );
  }
  AppBar _buildAppBar() {return AppBar(title:Text(IsUpdated?'Edit Post':"Add Post"));}
  Widget _buildBody()   
  {
    return Center
    (
      child: Padding
      (
        padding: EdgeInsets.all(10),
        child: BlocConsumer<PostCommandsBloc, PostCommandsBlocState>
          (
            listener: (context, state)
            {
              if(state is MessageCommandsPostState)
              {
                SnackBarMessages().ShowSuccessSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(_)=>PostsPage()),(route) => false);

              }
              else if(state is ErrorCommandsPostState)
              {
                SnackBarMessages().ShowErrorSnackBar(message: state.message, context: context);



              }
              
            },
            builder: (context, state)
            {
              if(state is LoadingCommandsPostState)
              return LoadingWidget();
              
              return FormWidget(isUpdated: IsUpdated,post: IsUpdated? post:null);
              
            },
        ),
      )
    
    );

  }
}
