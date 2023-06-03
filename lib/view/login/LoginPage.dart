import 'package:flutter/material.dart';
import '../../component/LoginBackground.dart';
import 'LoginForm.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return const LoginBackground(
      bottomImage: 'assets/images/login_bottom.png',
      heading: "LOGIN",
      child: LoginForm(),
    );
  }
}