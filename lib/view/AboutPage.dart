import 'package:address_list/GlobalVariable.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBGColor,
        title: Text('关于'),
      ),
      body: Container(
          width: double.infinity,
          color: bodyBGColor,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: defaultPadding * 8),
              Text(
                '通讯录',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              SizedBox(height: defaultPadding),
              Text(
                '版本号：1.0.0',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
              ),
              SizedBox(height: defaultPadding),
              Text(
                '作者：数字媒体技术212 韩骏',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '学号：1203002037',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                // textAlign: TextAlign.center,
              ),
              SizedBox(height:defaultPadding),
              Text(
                '联系我们：',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '邮箱：2840157186@qq.com',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
              ),
              Text(
                'GitHub：shinobisyun',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
              ),
            ],
          ),
      ),
    );
  }
}