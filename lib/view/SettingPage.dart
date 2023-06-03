import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/component/SettingBox.dart';
import 'package:address_list/view/AboutPage.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  @override
  State<SettingPage> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBGColor,
        title: Text(
          '设置',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25
          ),
        ),
      ),
      body: Container(
        color: bodyBGColor,
        child: ListView(
          children: [
            SettingBox(
              title: '不接收陌生号码消息',
              child : Switch(
                value: unacceptMessagesFromStranger,
                onChanged: (value) {
                  setState(() {
                    unacceptMessagesFromStranger = value; // 更新状态值
                  });
                },
              ),
            ),

            SettingBox(
              title: '检查更新',
              child: Icon(
                Icons.navigate_next,
                color: Colors.white70,
              ),
              onTap: (){},
            ),

            SettingBox(
              title: '关于我们',
              child: Icon(
                Icons.navigate_next,
                color: Colors.white70,
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}