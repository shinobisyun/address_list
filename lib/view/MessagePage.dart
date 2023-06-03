import 'package:flutter/material.dart';

import '../component/AppBar.dart';

class MessagePage extends StatefulWidget{
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>{

  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: [
        AppBarTool(currentIndexTitle: '消息'),
      ],
    );
  }
}