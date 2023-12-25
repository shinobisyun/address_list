import '../GlobalVariable.dart';

Future<bool> UpdateSchedule(Schedule schedule) async{
  if(schedule.time == '' || schedule.endTime == '' || schedule.description == ''){
    return false;
  }
  final table = 'calendar';
  Map<String, dynamic> values = {
    'time' : schedule.time,
    'endTime' : schedule.endTime,
    'description' : schedule.description,
    'place' : schedule.place
  };
  final condition = 'scheduleID = ${schedule.scheduleID}';
  try{
    final result = await mysql.update(table, values, condition);
    if(result > 0){   //修改成功
      return true;
    }else{    //修改失败
      return false;
    }
  }catch(e){   //未连接数据库
    print('Connection error: $e');
    mysql.ConnectToDatabase();
    return false;
  }
}