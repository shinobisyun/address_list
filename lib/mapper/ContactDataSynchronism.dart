import 'dart:convert';
import 'package:address_list/GlobalVariable.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

///保存数据库中的数据到本地Json文件中
Future<void> SaveContactData() async{
  final table = 'telephonelist';
  final columns = ['id','telephoneNumber', 'nickname', 'remark', 'indexLetter'];
  final where = 'id = ${userID}';
  //获取应用程序的私有文件目录
  Directory appDocDir = await getApplicationDocumentsDirectory();
  contactListPath = '${appDocDir.path}/telephonelist.json';
  // 从MySQL数据库中获取数据
  try{
    final result = await mysql.Select(
      table,
      columns: columns,
      where: where
    );
    List<Map<String, dynamic>> databaseData = result.map((row) => row.fields).toList();
    // 将数据转换为JSON字符串
    String jsonData = jsonEncode(databaseData);
    //打开文件
    if(contactListPath == null){
      print('路径错误');
    }else{
      File file = File(contactListPath!);
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
Future<void> ReadContactDataFromDB() async{
  final table = 'telephonelist';
  final columns = ['id','telephoneNumber', 'nickname', 'remark', 'indexLetter'];
  final where = 'id = ${userID}';
  // 从MySQL数据库中获取数据
  try {
    final result = await mysql.Select(
        table,
        columns: columns,
        where: where
    );
    contactList = _parseContacts(result);
  }catch(e){
    print('Read Data error: $e');
  }
}

///读取本地Json文件中的数据
Future<void> ReadContactDataFromJson() async{
  //打开文件
  File file = File(contactListPath!);
  //文件存在
  if(await file.exists()){
    //读取文件
    String? jsonString = await file.readAsString();
    if(jsonString != null){
      //解析为动态对象
      final jsonData = json.decode(jsonString);
      contactList = _parseContacts(jsonData);
    }else{
      contactList = [];
    }
  }else{
    print('File is not exist');
  }
}

//将List<dynamic>类型转化成List<Contact>
List<Contact> _parseContacts(List<dynamic> jsonData) {
  return jsonData.map((item) {
    return Contact(
        name: item['nickname'],
        phoneNumber: item['telephoneNumber'],
        indexLetter: item['indexLetter'],
        remark: item['remark'] ?? ''
    );
  }).toList();
}


