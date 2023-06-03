import '../GlobalVariable.dart';

Future<bool> AddSchedule(String time, String? place, String description) async{
  final table = 'calendar';
  final values = {
    'id' : userID,
    'time' : time,
    'place' : place == null ? null : place,
    'description' : description,
  };

  try{
    final result = await mysql.Insert(table, values);
    if(result == 0){   //添加失败
      return false;
    }else{    //添加成功
      return true;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    return false;
  }
}
