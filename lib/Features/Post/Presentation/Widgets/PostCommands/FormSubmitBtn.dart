import 'package:flutter/material.dart';
import 'package:post_ca/Core/Themes/app_theme.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        icon: isUpdatePost ? Icon(Icons.edit,color:Colors.white) : Icon(Icons.add,color:Colors.white),
        label: Text(isUpdatePost ? "Update" : "Add",style:const TextStyle(color:Colors.white)));
  }
}