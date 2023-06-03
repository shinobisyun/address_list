import 'package:flutter/material.dart';
import '../../component/LoginBackground.dart';
import 'SignupForm.dart';

class SignupPage extends StatelessWidget{
  const SignupPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return const LoginBackground(
      topImage: 'assets/images/signup_top.png',
      heading: "SIGN UP",
      child: SignupForm(),
    );
  }
}