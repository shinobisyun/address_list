import '../GlobalVariable.dart';

Future<bool> UpdateContact(Contact contact) async{
  if(contact.name == '' || contact.phoneNumber == ''){
    return false;
  }
  final table = 'telephonelist';
  Map<String, dynamic> values = {
    'nickName' : contact.name,
    'telephoneNumber' : contact.phoneNumber,
    'remark' : contact.remark
  };
  final condition = 'id = $userID and telephoneNumber = ${contact.phoneNumber}';
  try{
    final result = await mysql.update(table, values, condition);
    if(result == 0){   //修改失败
      return false;
    }else{    //修改成功
      return true;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    return false;
  }
}
