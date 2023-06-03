import 'package:address_list/mapper/ContactDataSynchronism.dart';
import 'package:address_list/view/LoadingPage.dart';
import 'package:address_list/view/contactlist/ContactsCell.dart';
import 'package:flutter/material.dart';
import '../../GlobalVariable.dart';
import '../../component/AppBar.dart';

class AddressBookPage extends StatefulWidget{
  const AddressBookPage({super.key});

  @override
  State<AddressBookPage> createState() => AddressBookPageState();
}

class AddressBookPageState extends State<AddressBookPage> {
  final List<Contact> _listDatas = [];
  bool isLoading = true;
  /*final INDEX_WORDS = [
    '#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  final List<Widget> _indexList = [];*/
  Future<void> fetchContacts() async{
    try{
      await mysql.connection!.query('SELECT * FROM telephonelist');
      await ReadContactDataFromDB();
    }catch(e){
      await ReadContactDataFromJson();
    }
    if(contactList != null){
      _listDatas.addAll(contactList!);
    }
    // 数组排序
    _listDatas.sort((Contact a, Contact b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    isLoading = false;
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    fetchContacts();
    /*//索引条
    for(int i = 0; i < INDEX_WORDS.length; i++){
      _indexList.add(Text(INDEX_WORDS[i], style: const TextStyle(fontSize: 12),));
    }*/
  }
  @override
  Widget build(BuildContext context) {
      if(isLoading == true){
        return LoadingPage();
      }
      return Container(
        color: themeLightColor,
        child: CustomScrollView(
            slivers: <Widget>[
              AppBarTool(currentIndexTitle: "联系人"),
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  final contact = _listDatas![index];
                  if((index > 0) && _listDatas![index].indexLetter == _listDatas![index-1].indexLetter){
                    contact.indexLetter = "";
                  }
                  return ContactsCell(contact: contact);
                }, childCount: _listDatas.length,)
              ),
            ]
        )
      );
  }
}

        /*SliverToBoxAdapter(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              ListView.builder(
                itemCount: 26,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                  return ListTile(
                    title: Text(letter),
                    onTap: () {
                      // 滚动到对应字母为首字母的位置
                      // 假设通讯录列表的 ScrollController 是 controller
                      //controller.jumpTo(index * 50.0);
                    },
                  );
                },
              ),
            ],
          ),
        ),*/
        /*SliverToBoxAdapter(   //用于插入非滚动内容的部件
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 5,
                width: 30,
                bottom: 0,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: _indexList,
                  ),
                ),
              )
            ],
          ),
        )*/