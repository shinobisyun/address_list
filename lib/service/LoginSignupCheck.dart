import 'package:flutter/material.dart';
import 'package:address_list/GlobalVariable.dart';

class LoginOrSignupCheck extends StatelessWidget{
  final bool login;
  final Function? press;
  const LoginOrSignupCheck({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(color: themeColor),
        ),
        GestureDetector(   //手势事件
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: themeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}