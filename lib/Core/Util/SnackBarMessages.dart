import 'package:flutter/material.dart';

class SnackBarMessages
{
  void ShowSuccessSnackBar({required String message,required BuildContext context})
  {
    ScaffoldMessenger.of(context).showSnackBar
    (
      SnackBar
      (
        content:Text(message,style:const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      )
    );
    
  }
  void ShowErrorSnackBar({required String message,required BuildContext context})
  {
    ScaffoldMessenger.of(context).showSnackBar
    (
      SnackBar
      (
        content:Text(message,style:const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      )
    );

  }
  
}