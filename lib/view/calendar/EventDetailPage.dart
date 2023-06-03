import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/service/DeleteSchedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'UpdateSchedulePage.dart';  // For date formatting

class EventDetailPage extends StatelessWidget {
  final Schedule event;

  EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final eventDate = DateTime.parse(event.time);
    return Scaffold(
      appBar: AppBar(
        title: Text('日程详情'),
        backgroundColor: appbarBGColor,
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(AssetImage('assets/icons/edit.png')),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSchedulePage(event: event)));
            },
          ),
          IconButton(
            icon:ImageIcon(AssetImage('assets/icons/delete.png')),
            color: Colors.redAccent,
            onPressed: () async{
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
                if(await DeleteSchedule(event)){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除成功')));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除失败')));
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        color: bodyBGColor,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            const SizedBox(height: defaultPadding * 2),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '日期: ${DateFormat('yyyy-MM-dd HH:mm').format(eventDate)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                )
              ),
            ),
            const SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                  '地点: ${event.place}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  )
              ),
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                    '详情: ${event.description}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                ),
              ),
              flex: 8,
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}