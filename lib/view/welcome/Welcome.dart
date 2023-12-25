import 'package:address_list/GlobalVariable.dart';
import 'package:flutter/material.dart';
import '../../component/LoginBackground.dart';
import '../../mapper/ContactDataSynchronism.dart';
import 'login_signup_btn.dart';
import 'package:address_list/mapper/DataSource.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WelcomePageState();
}
class WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    return const LoginBackground(
      heading: "WELCOME",
      child: LoginAndSignupBtn(),
    );
  }

  @override
  void initState() {
    _initDataBase();
  }

  Future<void>_initDataBase() async{
    await mysql.ConnectToDatabase();
  }
}