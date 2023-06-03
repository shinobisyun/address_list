import '../GlobalVariable.dart';

Future<bool> AddContact(String name, String phoneNumber, String? remark) async{
  final table = 'telephonelist';
  final values = {
    'id' : userID,
    'telephoneNumber' : phoneNumber,
    'nickName' : name == null ? phoneNumber : name,
    'remark' : remark ?? '',
    'indexLetter' : name[0].toUpperCase()
  };

  try{
    final query = await mysql.Select(table, where: 'id = $userID and telephoneNumber = $phoneNumber');
    if(query.isEmpty){
      final result = await mysql.Insert(table, values);
      if(result == 0){   //添加失败
        return false;
      }else{    //添加成功
        return true;
      }
    }else{
      return false;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    return false;
  }
}

