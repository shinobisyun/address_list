import 'package:address_list/component/PromptDialog.dart';
import 'package:flutter/material.dart';
import '../../GlobalVariable.dart';
import '../../service/AddContact.dart';

class AddContactPage extends StatefulWidget {
  @override
  State<AddContactPage> createState() => AddContactPageState();
}

class AddContactPageState extends State<AddContactPage>{
  bool isLoading = false;
  String? name;
  String? phoneNumber;
  String? remark;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新建联系人',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25
          ),
        ),
        backgroundColor: appbarBGColor,
        actions: [
          IconButton(
            onPressed: isLoading ? null : () async{
              if(phoneNumber == null || phoneNumber!.length != 11){
                PromptDialog(context, '请输入电话号码');
              }
              else if(name == null){
                PromptDialog(context, '请输入名字');
              } else{
                setState(() {
                  isLoading = true;
                });
                var result = await AddContact(name!,phoneNumber!,remark);
                await PromptDialog(context, result ? '添加成功' : '添加失败');
                Navigator.of(context).pop();
              }
              setState(() {
                isLoading = false;
              });
            },
            icon: isLoading ? CircularProgressIndicator() : Icon(Icons.check),
          )
        ],
      ),

      body: Container(
        color: bodyBGColor,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: defaultPadding * 5),
            Text(
              '保存至： 用户 $userPhoneNumber',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
              )
            ),
            const SizedBox(height: defaultPadding * 5),

            Row(
              children: <Widget>[
                const Spacer(),   //自动调整其大小以填充父容器中的所有可用空间

                Expanded(    //弹性容器，自动填充任何剩余的可用空间
                  flex: 8,   //占80%
                  child: Form(
                    autovalidateMode: AutovalidateMode.disabled,   //自动校验禁用，只在调用validate() 方法时触发
                    child: Column(
                      children: [
                        TextFormField(         //昵称
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input) {
                            name = input;
                          },
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                              hintText: '姓名',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.person_outline_sharp),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),

                        TextFormField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input){
                            phoneNumber = input;
                          },
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            hintText: '电话',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.phone),
                            ),
                          ),

                        ),
                        const SizedBox(height: defaultPadding),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input){
                            remark = input;
                          },
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            hintText: '备注',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.notes),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            )
          ],
        )
      ),
    );
  }
}