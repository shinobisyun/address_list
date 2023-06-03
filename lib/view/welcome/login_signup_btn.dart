import 'package:address_list/GlobalVariable.dart';
import 'package:flutter/material.dart';
import '../login/LoginPage.dart';
import '../signup/SignupPage.dart';

class LoginAndSignupBtn extends StatelessWidget{
  const LoginAndSignupBtn({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Hero(       //动画组件
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return LoginPage();
                })
              );
            },
            style: ElevatedButton.styleFrom(
                primary: loginAndSignupColor
            ),
            child: Text("Login".toUpperCase()),
          ),
        ),
        const SizedBox(height: defaultPadding),
        Hero(       //动画组件
          tag: "signup_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return SignupPage();
                  })
              );
            },
            style: ElevatedButton.styleFrom(
                primary: loginAndSignupColor
            ),
            child: Text(
              "Signup".toUpperCase(),
              //style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}