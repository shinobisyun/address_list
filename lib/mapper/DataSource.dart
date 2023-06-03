import 'package:mysql1/mysql1.dart';

class MySql{
  MySqlConnection? connection;
  final settings = ConnectionSettings(
    host: 'hjhcj.com',
    port: 3306,
    user: 'FlutterAddressLt',
    password: '326326',
    db: 'flutteraddresslt',
  );
  ///连接数据库
  Future<String?> ConnectToDatabase() async{
    try{
      connection = await MySqlConnection.connect(settings);
      return null;
    }catch(e){
      return e.toString();
    }
  }
  ///关闭数据库
  Future<void> CloseConnection() async {
    if (connection != null) {
      await connection!.close();
      connection = null;
    }
  }
  ///数据库查询操作
  Future<List<ResultRow>> Select(String table, {List<String>? columns, String? where, String? orderBy, int? limit}) async {
    final query = StringBuffer('SELECT');
    if (columns != null && columns.isNotEmpty) {
      query.write(' ${columns.join(',')}');
    } else {
      query.write(' *');
    }
    query.write(' FROM $table');
    if (where != null && where.isNotEmpty) {
      query.write(' WHERE $where');
    }
    if (orderBy != null && orderBy.isNotEmpty) {
      query.write(' ORDER BY $orderBy');
    }
    if (limit != null) {
      query.write(' LIMIT $limit');
    }
    final results = await connection!.query(query.toString());
    return results.toList();
  }
  ///数据库添加操作
  Future<int> Insert(String table, Map<String, dynamic> values) async {
    final result = await connection!.query(
      'INSERT INTO $table (${values.keys.join(',')}) VALUES (${values.values.map((v) => "'$v'").join(',')})',
    );
    return result.affectedRows!;
  }
  ///数据库修改操作
  Future<int> update(String table, Map<String, dynamic> values, String condition) async {
    final result = await connection!.query(
      'UPDATE $table SET ${values.entries.map((e) => '${e.key} = ${e.value is String ? "'${e.value}'" : e.value}').join(',')} WHERE $condition',
    );
    return result.affectedRows!;
  }
  ///数据库删除操作
  Future<int> delete(String table, String condition) async {
    final result = await connection!.query('DELETE FROM $table WHERE $condition');
    return result.affectedRows!;
  }
}