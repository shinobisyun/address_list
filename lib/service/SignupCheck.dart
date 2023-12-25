import '../GlobalVariable.dart';

Future<int> SignupCheck(String phonenumber, String password) async{
  final table = 'user';
  final values = {
    'username':phonenumber,
    'password':password
  };

  try{
   final result = await mysql.Insert(table, values);
   if(result == 0){   //注册失败
     return 0;
   }else
     return result;   //注册成功
  }catch(e) {   //未连接数据库
    print('Connection error: $e');
    mysql.ConnectToDatabase();
    return -1;
  }
}