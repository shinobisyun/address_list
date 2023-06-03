import 'package:flutter/material.dart';
import '../GlobalVariable.dart';

class LoginBackground extends StatelessWidget{
  final Widget child;
  final String heading;
  const LoginBackground({
    Key? key,
    required this.heading,
    required this.child,
    this.topImage =  'assets/images/main_top.png',
    this.bottomImage = 'assets/images/main_bottom.png',
  }) :super(key: key);
  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  //当软键盘弹出时，是否自动调整页面大小以避免被软键盘遮挡
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,  //获取当前设备屏幕高度
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(     //绝对定位
              top: 0,
              left: 0,
              child: Image.asset(topImage, width: 120)
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 120)
            ),
            SafeArea(      //安全容器
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    )
                  ),
                  const SizedBox(height: defaultPadding * 6),
                  Row(
                    children: <Widget>[
                      const Spacer(),   //自动调整其大小以填充父容器中的所有可用空间
                      Expanded(    //弹性容器，自动填充任何剩余的可用空间
                        flex: 8,   //占80%
                        child: child,
                      ),
                      const Spacer()
                    ],
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}