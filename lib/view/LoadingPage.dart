import 'package:address_list/GlobalVariable.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget{
  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: bodyBGColor,
        alignment: Alignment.center,
        child: Text(
            'loading...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24
          ),
        ),
      ),
    );
  }
}