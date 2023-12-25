import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/service/DeleteContact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/MyHomePage.dart';
import 'UpdateContactPage.dart';

class ContactsCellDetail extends StatefulWidget {
  ContactsCellDetail({Key? key, required this.contact});
  Contact contact;

  @override
  State<ContactsCellDetail> createState() => ContactsCellDetailState();
}

class ContactsCellDetailState extends State<ContactsCellDetail>
{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBGColor,
        leading: IconButton(
          tooltip: '返回上一页',
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context, widget.contact);
          },
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) async{
              if(value == 1){
                widget.contact = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateContactPage(contact: widget.contact))
                );
                setState((){});
              }
              else if(value == 2){
                final confirmDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('确定要删除吗?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('取消'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('删除'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );
                if (confirmDelete == true) {
                  if(await DeleteContact(widget.contact)){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除成功')));   // 如果成功就跳转并重加载页面
                    Navigator.pushAndRemoveUntil(   //新建路由，删除之前的路由
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                          settings:RouteSettings(
                            arguments: 2,
                          )
                      ),
                          (Route<dynamic> route) => false,
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除失败')));
                  }
                }
              }
            },
            icon: Icon(Icons.keyboard_control),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  '编辑联系人'
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  '删除联系人'
                ),
              ),
              /*PopupMenuItem(
                value: 3,
                child: Text(
                  '屏蔽联系人'
                ),
              )*/
            ],
          ),
        ],
      ),
      body: Container(
        color: bodyBGColor,
        child: Column(
          children: <Widget>[
            const SizedBox(height: defaultPadding * 4),
            CircleAvatar(
              foregroundColor: Colors.white70,  //字母颜色（没头像时）
              backgroundColor: Colors.grey[700],   //背景颜色（没头像时）
              radius: 50,
              child: Text(
                widget.contact.name!.substring(widget.contact.name!.length-1),   //选取最后一个字
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),

            Text(
              widget.contact.name!,
              style: TextStyle(
                color: Colors.white,
                fontSize:35,
              ),
            ),
            const SizedBox(height: defaultPadding *2),

            Row(
              children: [
                const Spacer(),

                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          '电话',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white60,
                          ),
                        ),
                        width: double.infinity,
                      ),
                      //const SizedBox(height: defaultPadding),

                      ListTile(
                        title: Text(
                          widget.contact.phoneNumber!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: (){
                                launch("tel:${widget.contact.phoneNumber}");
                              },
                              icon:Icon(Icons.phone_outlined),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[800],
                      ),

                      Container(
                        height: widget.contact.remark == "" ? 0 : 75,
                        //color: Colors.red,
                        child: ListTile(
                          title: Text(
                            widget.contact.remark == "" ? '' : widget.contact.remark!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '备注',
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: widget.contact.remark == "" ? 0 : 1,
                        color: Colors.grey[800],
                      ),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            )
          ],
        ),
      )
    );
  }
}