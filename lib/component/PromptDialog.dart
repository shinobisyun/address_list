import 'package:flutter/material.dart';

Future<void> PromptDialog(BuildContext context, String dialog) async{
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      //title: Text('登录成功'),
      content: Text(dialog),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}