import '../GlobalVariable.dart';

Future<AddContactResult?> AddContact(String name, String phoneNumber, String? remark) async{
  final table = 'telephonelist';
  final values = {
    'id' : userID,
    'telephoneNumber' : phoneNumber,
    'nickName' : name == null ? phoneNumber : name,
    'remark' : remark ?? '',
    'indexLetter' : name[0].toUpperCase()
  };
  final where1 = 'id = $userID and telephoneNumber = $phoneNumber';
  final where2 = "id = $userID and nickName = '$name'";
  try{
    final query1 = await mysql.Select(table, where: where1);
    final query2 = await mysql.Select(table, where: where2);
    if(query1.isEmpty && query2.isEmpty){
      final result = await mysql.Insert(table, values);
      if(result == 0){   //添加失败
        return AddContactResult.addError;
      }else{    //添加成功
        return AddContactResult.addSuccess;
      }
    }else if(query1.isEmpty == false){
      return AddContactResult.alreadyPhone;
    }else if(query2.isEmpty == false){
      return AddContactResult.alreadyName;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    mysql.ConnectToDatabase();
    return AddContactResult.connectError;
  }
}

