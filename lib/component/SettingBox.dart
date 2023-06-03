import 'package:flutter/material.dart';

class SettingBox extends StatelessWidget{
  final Widget child;
  final String title;
  void Function()? onTap;
  SettingBox({
    Key? key,
    required this.child,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10), // 设置圆角半径为 10
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500
          ),
        ),
        trailing: child,
        onTap: onTap == null ? null : onTap,
      ),
    );
  }
}

