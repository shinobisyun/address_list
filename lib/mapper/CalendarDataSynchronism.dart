import 'dart:convert';
import 'package:address_list/GlobalVariable.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

///保存数据库中的数据到本地Json文件中
Future<void> SaveCalendarData() async{
  final table = 'calendar';
  final columns = ['id','time','endTime', 'place', 'description', 'scheduleID'];
  final where = 'id = ${userID}';
  //获取应用程序的私有文件目录
  Directory appDocDir = await getApplicationDocumentsDirectory();
  scheduleListPath = '${appDocDir.path}/schedulelist.json';
  // 从MySQL数据库中获取数据
  try{
    final result = await mysql.Select(
        table,
        columns: columns,
        where: where
    );
    List<Map<String, dynamic>> databaseData = result.map((row) => row.fields).toList();
    for(var date in databaseData){
      date['time'] = date['time'].toString();
      date['endTime'] = date['endTime'].toString();
    }
    // 将数据转换为JSON字符串
    String jsonData = jsonEncode(databaseData);
    //打开文件
    if(scheduleListPath == null){
      print('路径错误');
    }else{
      File file = File(scheduleListPath!);
      //文件不存在时
      if(!file.existsSync()){
        //递归创建文件
        file.createSync(recursive: true);
      }
      // 将JSON字符串写入文件
      file.writeAsString(jsonData);
    }
  }catch(e){
    print('Save Data error: $e');
  }
}

///读取数据库中的数据
Future<void> ReadCalendarDataFromDB() async{
  final table = 'calendar';
  final columns = ['id','time','endTime', 'place', 'description', 'scheduleID'];
  final where = 'id = ${userID}';
  // 从MySQL数据库中获取数据
  try {
    final result = await mysql.Select(
        table,
        columns: columns,
        where: where
    );
    scheduleList = _parseSchedules(result);
  }catch(e){
    print('Read Data error: $e');
  }
}

///读取本地Json文件中的数据
Future<void> ReadCalendarDataFromJson() async{
  //打开文件
  File file = File(scheduleListPath!);
  //文件存在
  if(await file.exists()){
    //读取文件
    String? jsonString = await file.readAsString();
    if(jsonString != null){
      //解析为动态对象
      final jsonData = json.decode(jsonString);
      scheduleList = _parseSchedules(jsonData);
    }else{
      scheduleList = [];
    }
  }else{
    print('File is not exist');
  }
}

//将List<dynamic>类型转化成List<Contact>
List<Schedule> _parseSchedules(List<dynamic> jsonData) {
  return jsonData.map((item) {
    return Schedule(
        time: item['time'].toString(),
        endTime: item['endTime'].toString(),
        place: item['place'] ?? "",
        description: item['description'],
        scheduleID: item['scheduleID']
    );
  }).toList();
}