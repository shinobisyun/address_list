import 'package:flutter/material.dart';
import '../../GlobalVariable.dart';
import '../../component/PromptDialog.dart';
import '../../service/UpdateContact.dart';

class UpdateContactPage extends StatefulWidget{
  const UpdateContactPage({required this.contact});
  final contact;
  @override
  State<UpdateContactPage> createState() => UpdateContactPageState();
}

class UpdateContactPageState extends State<UpdateContactPage> {
  bool isLoading = true;
  Contact? _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '编辑联系人',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25
          ),
        ),
        backgroundColor: appbarBGColor,
        actions: [
          IconButton(
            onPressed: isLoading ? null : () async{
              if(_contact!.phoneNumber != null && _contact!.phoneNumber.length != 11){
                PromptDialog(context, '请输入电话号码');
              } else{
                setState(() {
                  isLoading = true;
                });
                var result = await UpdateContact(_contact!);
                if(result){
                  PromptDialog(context, '修改成功');
                }else{
                  PromptDialog(context, '修改失败');
                }
              }
              setState(() {
                isLoading = false;
              });
            },
            icon: Icon(Icons.check),
          )
        ],
      ),

      body: Container(
        color: bodyBGColor,
        child: Column(
          children: [
            const SizedBox(height: defaultPadding * 2),
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
                          initialValue: _contact!.name,   //原本的值
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input) {
                            _contact!.name = input;
                            setState(() {
                              isLoading = false;
                            });
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
                          initialValue: _contact!.phoneNumber,   //原本的值
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input){
                            _contact!.phoneNumber = input;
                            setState(() {
                              isLoading = false;
                            });
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
                          initialValue: _contact!.remark,   //原本的值
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          cursorColor: Colors.lightGreen,
                          onChanged: (input){
                            _contact!.remark = input;
                            setState(() {
                              isLoading = false;
                            });
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
                        ),
                        const SizedBox(height: defaultPadding * 2),

                        Container(
                          child: Text(
                            '来自账户:  $userPhoneNumber',
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        )
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}