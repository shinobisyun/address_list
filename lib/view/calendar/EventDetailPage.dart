import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/service/DeleteSchedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../component/MyHomePage.dart';
import 'UpdateSchedulePage.dart';  // For date formatting

class EventDetailPage extends StatefulWidget {
  Schedule event;
  EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => EventDetailPageState();
}

class EventDetailPageState extends State<EventDetailPage>{
  @override
  Widget build(BuildContext context) {
    final eventDate = DateTime.parse(widget.event.time);
    final eventEndTime = DateTime.parse(widget.event.endTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('日程详情'),
        backgroundColor: appbarBGColor,
        leading: IconButton(
          tooltip: '返回上一页',
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context, widget.event);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(AssetImage('assets/icons/edit.png')),
            onPressed: () async {
              widget.event = await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSchedulePage(event: widget.event)));
              setState(() {});
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
                if(await DeleteSchedule(widget.event)){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除成功')));   // 如果成功就跳转并重加载页面
                  Navigator.pushAndRemoveUntil(   //新建路由，删除之前的路由
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                        settings:RouteSettings(
                          arguments: 1,
                        )
                    ),
                        (Route<dynamic> route) => false,
                  );
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
            const SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '开始时间: ${DateFormat('yyyy-MM-dd HH:mm').format(eventDate)}',
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
                  '结束时间: ${DateFormat('yyyy-MM-dd HH:mm').format(eventEndTime)}',
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
                  '地点: ${widget.event.place}',
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
                    '详情: ${widget.event.description}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                ),
              ),
              flex: 9,
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}