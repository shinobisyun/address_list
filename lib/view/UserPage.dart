import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/view/SettingPage.dart';
import 'package:address_list/view/welcome/Welcome.dart';
import 'package:flutter/material.dart';

import '../component/MyHomePage.dart';

class UserPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBGColor,
      ),

      body: Container(
        color: bodyBGColor,
        child: Column(
          children: [
            const SizedBox(height: defaultPadding * 5),
            CircleAvatar(
              foregroundColor: Colors.white70,  //字母颜色（没头像时）
              backgroundColor: Colors.grey[700],   //背景颜色（没头像时）
              foregroundImage: AssetImage('assets/images/user_acatar.jpg'),
              radius: 50,
              child: Icon(
                Icons.person,
                size: 45,
              ),
            ),
            const SizedBox(height: defaultPadding),

            Text(
              userPhoneNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize:20,
              ),
            ),
            const SizedBox(height: defaultPadding *2),

            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage())
                );
              },
              child: Container(   //设置按钮
                width: double.infinity,
                padding: EdgeInsets.all(25),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      size: 25,
                      color: themeLightColor,
                    ),
                    const SizedBox(width: defaultPadding),
                    Text(
                      '设置',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeLightColor,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.navigate_next,
                      size: 25,
                      color: themeLightColor,
                    )
                  ],
                ),
              ),
            ),

            Container(   //分割线
              padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 9,
                    child: Container(
                      height: 1,
                      width: 100,
                      color: themeColor,
                    )
                  )
                ],
              ),
            ),

            const Spacer(),
            Row(             //退出按钮
              children: [
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(   //新建路由，删除之前的路由
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        '退出登录',
                        style: TextStyle(
                            color: Colors.redAccent
                        ),
                      )
                  ),
                  flex: 8,
                ),
                const Spacer()
              ],
            ),
            const SizedBox(height: defaultPadding * 2)
          ],
        ),
      ),
    );
  }
}