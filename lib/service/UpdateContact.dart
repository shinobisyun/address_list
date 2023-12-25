import '../GlobalVariable.dart';

Future<bool> UpdateContact(Contact contact) async{
  if(contact.name == '' || contact.phoneNumber == ''){
    return false;
  }
  final table = 'telephonelist';
  Map<String, dynamic> values = {
    'nickName' : contact.name,
    'telephoneNumber' : contact.phoneNumber,
    'remark' : contact.remark,
    'indexLetter' : contact.name[0].toUpperCase(),
  };
  final condition = 'id = $userID and telephonelistID = "${contact.contactID}"';
  try{
    final result = await mysql.update(table, values, condition);
    if(result > 0){   //修改成功
      return true;
    }else{    //修改失败
      print(result);
      return false;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    mysql.ConnectToDatabase();
    return false;
  }
}
