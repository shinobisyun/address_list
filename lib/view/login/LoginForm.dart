import 'package:flutter/material.dart';
import 'package:address_list/GlobalVariable.dart';
import '../../component/PromptDialog.dart';
import '../../service/LoginSignupCheck.dart';
import '../signup/SignupPage.dart';
import '../../component/MyHomePage.dart';
import 'package:address_list/service/LoginCheck.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}):super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,   //自动校验禁用，只在调用validate() 方法时触发
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.number,     //键盘输入样式
            textInputAction: TextInputAction.next,    //下一步按键样式
            cursorColor: loginAndSignupColor,
            onSaved: (phonenumber) {},      //保存到phonenumber中
            decoration: InputDecoration(      //表单装饰
              hintText: '手机号',          //未输入时的显示文字
              prefixIcon: Padding(          //前缀Icon
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
          TextFormField(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,   //是否隐藏
            cursorColor: loginAndSignupColor,
            decoration: InputDecoration(
              hintText: "密码",
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
          const SizedBox(height: defaultPadding * 2),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(    //登录按钮
                onPressed: isLoading ? null : () async {
                  if (formKey!.currentState!.validate()) {    //执行validator
                    setState(() {
                      isLoading = true;
                    });
                    var result = await LoginCheck(_usernameController, _passwordController);
                    if (result == 1) {
                      await PromptDialog(context, '登录成功');
                      Navigator.pushAndRemoveUntil(   //新建路由，删除之前的路由
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()),
                            (Route<dynamic> route) => false,
                      );
                    }
                    else if(result == 2)
                      PromptDialog(context, '账号或密码错误');
                    else if(result == 0)
                      PromptDialog(context, '账号未注册');
                    else if(result == -1)
                      PromptDialog(context, '登录失败');
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: loginAndSignupColor
                ),
                child: isLoading ? CircularProgressIndicator() : Text(
                    "LOGIN")
            ),
          ),
          const SizedBox(height: defaultPadding),
          LoginOrSignupCheck(
            login: true,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignupPage();
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}