import 'package:address_list/view/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:address_list/GlobalVariable.dart';
import '../../component/PromptDialog.dart';
import '../../service/LoginSignupCheck.dart';
import '../../service/SignupCheck.dart';

class SignupForm extends StatefulWidget{
  const SignupForm({Key? key}) :super(key: key);

  @override
  State<StatefulWidget> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? phoneNumber;
  String? password;
  String? repassword;

  @override
  Widget build(BuildContext context){
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,   //自动校验禁用，只在调用validate() 方法时触发
      child: Column(
        children: [
          TextFormField(    //账号
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: loginAndSignupColor,
            onChanged: (input) {
              phoneNumber = input;
            },
            decoration: InputDecoration(
              hintText: '手机号',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone_iphone),
              ),
              fillColor: loginAndSignupLightColor,
              prefixIconColor: loginAndSignupColor,
              hintStyle: TextStyle(
                 color: Colors.black
              ),
              labelStyle: TextStyle(
                color: Colors.black
              )
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length != 11) {
                return '请输入你的手机号';
              }else
                return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(     //密码
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: loginAndSignupColor,
            onChanged: (input) {
              password = input;
            },
            decoration: InputDecoration(
              hintText: '密码',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
              fillColor: loginAndSignupLightColor,
              prefixIconColor: loginAndSignupColor,
              hintStyle: TextStyle(
                color: Colors.black
              ),
              labelStyle: TextStyle(
                color: Colors.black
              )
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入你的密码';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(    //确认密码
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: loginAndSignupColor,
            onChanged: (input) {
              repassword = input;
            },
            decoration: InputDecoration(
              hintText: '确认密码',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock_outline),
              ),
              fillColor: loginAndSignupLightColor,
              prefixIconColor: loginAndSignupColor,
              hintStyle: TextStyle(
                color: Colors.black
              ),
              labelStyle: TextStyle(
                color: Colors.black
              )
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请再次输入你的密码';
              }else if(value != password){
                return '密码输入错误';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding * 2),
          Hero(
            tag: 'signup_btn',
            child: ElevatedButton(    //注册按钮
              onPressed: isLoading ? null : () async{
                if (formKey!.currentState!.validate()) { //执行validator
                  setState(() {
                    isLoading = true;
                  });
                  var result = await SignupCheck(phoneNumber!,password!);
                  if(result == 0 || result == -1){
                    PromptDialog(context, '注册失败，请重试');
                  }else{
                    await PromptDialog(context, '注册成功');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return LoginPage();
                      })
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: loginAndSignupColor
              ),
              child: isLoading ? CircularProgressIndicator() : Text(
                  "SIGNUP")
            ),
          ),
          const SizedBox(height: defaultPadding),
          LoginOrSignupCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return LoginPage();
                })
              );
            }
          ),
        ],
      )
    );
  }
}