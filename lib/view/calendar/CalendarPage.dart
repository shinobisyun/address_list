import 'package:address_list/mapper/CalendarDataSynchronism.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // For date formatting
import '../../GlobalVariable.dart';
import '../../component/AppBar.dart';
import '../LoadingPage.dart';
import 'EventDetailPage.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Schedule> events = [];  // This list will be populated from your database
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();  // Fetch events from database when the widget is initialized
  }

  void fetchEvents() async {
    try{
      await mysql.connection!.query('SELECT * FROM calendar');
      await ReadCalendarDataFromDB();
    }catch(e){
      await ReadCalendarDataFromJson();
    }
    if(scheduleList != null){
      events.addAll(scheduleList!);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading == true){
      return LoadingPage();
    }
    return Container(
      color: bodyBGColor,
      child: CustomScrollView(
        slivers: <Widget>[
          AppBarTool(currentIndexTitle: '日程'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                if (index == events.length) {
                  // 占位
                  return Container(height: 100);
                }else {
                  final event = events[index];
                  final eventDate = DateTime.parse(event.time);
                  final now = DateTime.now();
                  final difference = eventDate.difference(now);
                  return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: themeColor
                      ),
                      child: ListTile(
                        title: Text(event.description,
                          style: TextStyle(color: Colors.white),),
                        subtitle: Text(
                          '${event.place == '' ? '' : '地点: ${event.place}\n'}时间: ${DateFormat('yyyy-MM-dd').format(eventDate)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text('还有${difference.inDays}天',
                          style: TextStyle(color: Colors.white),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => EventDetailPage(event: event)));
                        },
                      )
                  );
                }
              },
              childCount: events.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}