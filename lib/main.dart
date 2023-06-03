import 'package:address_list/view/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'GlobalVariable.dart';
import 'view/welcome/Welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [         //负责提供不同语言环境下的文本、日期、时间等相关信息
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [   //语言环境
        const Locale('zh', 'CN'),  // Chinese
      ],
      title: 'address_list',
      theme: ThemeData(
        primaryColor: appbarBGColor,
        //brightness: Brightness.dark,
        //scaffoldBackgroundColor:Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(   //ElevatedButtonThemeData按钮主题配置
          style:ElevatedButton.styleFrom(  //styleFrom将简单值转换为与ElevatedButton的默认值一致的ButtonStyle。
            elevation: 0,   //阴影值
            primary: themeColor,    //主题颜色
            shape: const StadiumBorder(),  //形状
            maximumSize: const Size(double.infinity, 56),   //最大尺寸
            minimumSize: const Size(double.infinity, 56),   //最小尺寸
          )
        ),
        inputDecorationTheme: const InputDecorationTheme(  //设置输入框的默认样式
          filled: true,  //是否填充
          fillColor: themeColor,   //填充背景色
          iconColor: themeLightColor,  //非前缀图标颜色
          prefixIconColor: themeLightColor,  //前缀图标颜色
          contentPadding: EdgeInsets.symmetric(  //输入框内边距
              horizontal: defaultPadding,
              vertical: defaultPadding
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),   //输入框圆角
            borderSide: BorderSide.none   //边框大小
          ),
          hintStyle: TextStyle(
            color: themeLightColor,
          ),
        )
      ),
      //home: LoadingPage(),
      home: const WelcomePage(),
      // initialRoute: '/login',
      // routes: {
      //   '/':(context) => MyHomePage(),
      //   '/login':(context) => LoginPage(),
      // },
    );
  }
}


