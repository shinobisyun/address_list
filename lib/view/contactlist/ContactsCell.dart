import 'package:address_list/view/contactlist/ContactsCellDetail.dart';
import 'package:flutter/material.dart';
import '../../GlobalVariable.dart';

class ContactsCell extends StatelessWidget{
  const ContactsCell({required this.contact});
  final contact;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 60 + (contact.indexLetter != "" ? 40 : 0),
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,  //设备宽度
            padding: contact.indexLetter != "" ? EdgeInsets.symmetric(horizontal: defaultPadding) : EdgeInsets.all(0),
            height: contact.indexLetter != "" ? 40 : 0,
            child: contact.indexLetter != "" ? Text(
              contact.indexLetter!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ) : const Text(''),
          ),
          InkWell(  //捕获触摸事件
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsCellDetail(contact: contact)),
              );
            },
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Row(  //图标+名字
                    children: [
                      CircleAvatar(
                        foregroundColor: Colors.white70,  //字母颜色（没头像时）
                        backgroundColor: Colors.grey[700],   //背景颜色（没头像时）
                        radius: 20,
                        child: Text(
                          contact.name!.substring(contact.name!.length-1),   //选取最后一个字
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(   //昵称
                        contact.name!,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  flex: 9,
                ),
                const Spacer(),
              ],
            ),
          ),
          /*Row(   //分割线
            children: [
              Container(
                width: 50,
                height: 1,
                //color: kPrimaryLightColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 1,
                color: Colors.grey,
              )
            ],
          )*/
        ],
      ),
    );
  }
}