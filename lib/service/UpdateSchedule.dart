import '../GlobalVariable.dart';

Future<bool> UpdateSchedule(String time, String? place, String description, int scheduleID) async{
  final table = 'calendar';
  Map<String, dynamic> values = {
    'time' : time,
    'description' : description,
  };
  if(place != null){
    values.putIfAbsent('place', () => place);
  }
  final condition = 'scheduleID = $scheduleID';
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