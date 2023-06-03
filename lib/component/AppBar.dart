import 'package:address_list/TestPage.dart';
import 'package:address_list/view/SearchPage.dart';
import 'package:address_list/view/UserPage.dart';
import 'package:address_list/view/contactlist/AddContactPage.dart';
import 'package:flutter/material.dart';
import '../GlobalVariable.dart';

class AppBarTool extends StatelessWidget {
  const AppBarTool({Key? key, required this.currentIndexTitle}) : super(key: key);
  final String currentIndexTitle;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appbarBGColor,
      pinned: true,  //标题栏是否固定
      actions: <Widget>[
        /*IconButton(     //查询
          icon:Icon(Icons.search),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          iconSize: 25,
        ),*/
        /*IconButton(     //添加
          icon: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContactPage()),
            );
          },
          iconSize: 30,
        ),*/
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: CircleAvatar(
            foregroundColor: Colors.white,  //字母颜色（没头像时）
            backgroundColor: Colors.blueAccent,   //背景颜色（没头像时）
            radius: 20,   //设置大小
            foregroundImage: AssetImage('assets/images/user_acatar.jpg',),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage())
                );
              },
            ),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          currentIndexTitle,
          style: const TextStyle(
            fontSize: 21,
            fontFamily: '微软雅黑'
          ),
        ),
        titlePadding: const EdgeInsets.all(15),
        expandedTitleScale: 2,  //倍数
      ),
      expandedHeight: 130,  //合并高度
    );
  }
}
