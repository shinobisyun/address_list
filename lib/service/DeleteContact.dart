import '../GlobalVariable.dart';

Future<bool> DeleteContact(Contact contact) async{
  final table = 'telephonelist';
  final condition = 'id = $userID and telephoneNumber = ${contact.phoneNumber}';

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