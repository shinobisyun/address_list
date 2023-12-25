import '../GlobalVariable.dart';

Future<bool> DeleteSchedule(Schedule schedule) async{
  final table = 'calendar';
  final condition = 'scheduleID = ${schedule.scheduleID}';

  try{
    final result = await mysql.delete(table, condition);
    if(result == 1){
      return true;
    }else{
      return false;
    }
  }catch(e){
    print('Delete contact error: $e');
    mysql.ConnectToDatabase();
    return false;
  }
}