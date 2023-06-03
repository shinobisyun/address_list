import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> ShowDoubleDialog(BuildContext context, String dialog, void Function() onPressed) async{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('确定要删除吗？'),
        actions: [
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop(); // 关闭弹窗
            },
          ),
          TextButton(
            child: Text(dialog,style: TextStyle(color: Colors.red),),
            onPressed: () {
              onPressed;
            },
          ),
        ],
      );
    },
  );
}