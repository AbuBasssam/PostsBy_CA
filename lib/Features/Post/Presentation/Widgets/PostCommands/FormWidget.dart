import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';
import 'package:post_ca/Features/Post/Presentation/Bloc/CommandsPostBloc/post_commands_bloc_bloc.dart';

import '../../../Domain/Entities/Post.dart';
import 'FormSubmitBtn.dart';
import 'TextFormFieldwidget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdated; // Changed to camelCase
  final Post? post;

  const FormWidget({super.key, required this.isUpdated, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>(); // Corrected type

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState(); // Call super first

    if (widget.isUpdated)
   {
      _titleController.text = widget.post!.Title; // Changed to camelCase
      _bodyController.text = widget.post!.Body; // Changed to camelCase
   }
  }

  @override
  Widget build(BuildContext context)
 {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
         TextFormFieldWidget
         (
          name: "Title",
          multiLines: false,
          controller: _titleController
         ),

         TextFormFieldWidget
         (
          name: "Body",
          multiLines: true,
          controller: _bodyController
         ),
          
          FormSubmitBtn
          (
            isUpdatePost: widget.isUpdated,
            onPressed: validateFormThenUpdateOrAddPost
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate(); // Corrected method call
    if (isValid) {
      final post = PostDTO(
        Id: widget.isUpdated ? widget.post!.Id : null, // Changed to camelCase
        Title: _titleController.text,
        Body: _bodyController.text,
      );

      widget.isUpdated ? _updatePost(context, post) : _addNewPost(context, post);
    }
  }

  void _updatePost(BuildContext context, PostDTO post)
  {
    Post updatedPost = Post(Id: post.Id!, Title: post.Title, Body: post.Body); // Changed to camelCase
    BlocProvider.of<PostCommandsBloc>(context).add(UpdatePostEvent(post: updatedPost));
  }

  void _addNewPost(BuildContext context, PostDTO post)
=> BlocProvider.of<PostCommandsBloc>(context).add(AddPostEvent(post: post));

  // ElevatedButton _buildButton() {
  //   return ElevatedButton.icon(
  //     onPressed: validateFormThenUpdateOrAddPost, // Call validation method
  //     icon: widget.isUpdated ? Icon(Icons.update) : Icon(Icons.add),
  //     label: Text(widget.isUpdated ? "Update" : "Add"),
  //   );
  // }

  // Padding _buildBodyTextField() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  //     child: TextFormField(
  //       controller: _bodyController,
  //       validator: (value) => value!.isEmpty ? "Body can't be empty" : null,
  //       decoration: const InputDecoration(
  //         hintText: "Body",
  //       ),
  //       minLines: 6,
  //       maxLines: 8,
  //     ),
  //   );
  // }

  // Padding _buildTitleTextField() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  //     child: TextFormField(
  //       controller: _titleController,
  //       validator: (value) => value!.isEmpty ? "Title can't be empty" : null,
  //       decoration: const InputDecoration(
  //         hintText: "Title",
  //       ),
  //     ),
  //   );
  // }

  
 
}