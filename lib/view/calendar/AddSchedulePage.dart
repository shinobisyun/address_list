import 'package:address_list/component/PromptDialog.dart';
import 'package:flutter/material.dart';
import '../../GlobalVariable.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';  // For date formatting
import '../../service/AddSchedule.dart';
import 'CalendarPage.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  State<AddSchedulePage> createState() => AddSchedulePageState();
}

class AddSchedulePageState extends State<AddSchedulePage>{
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBGColor,
        title: Text('添加日程'),
      ),
      body: Container(
        color: bodyBGColor,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding* 2),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: defaultPadding * 5),
              DateTimeField(
                controller: _dateController,
                format: DateFormat('yyyy-MM-dd HH:mm'),
                decoration: InputDecoration(
                    labelText: '时间',
                    labelStyle: TextStyle(
                        color: Colors.white70
                    )
                ),
                style: TextStyle(
                  color: Colors.white,

                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              const SizedBox(height: defaultPadding),

              DateTimeField(
                controller: _endTimeController,
                format: DateFormat('yyyy-MM-dd HH:mm'),
                decoration: InputDecoration(
                    labelText: '结束时间',
                    labelStyle: TextStyle(
                        color: Colors.white70
                    )
                ),
                style: TextStyle(
                  color: Colors.white,

                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              const SizedBox(height: defaultPadding),

              TextFormField(
                controller: _placeController,
                cursorColor: Colors.lightGreen,
                decoration: InputDecoration(
                  labelText: '地点',
                  labelStyle: TextStyle(
                    color: Colors.white70
                  )
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: defaultPadding),

              TextFormField(
                controller: _descriptionController,
                cursorColor: Colors.lightGreen,
                decoration: InputDecoration(
                  labelText: '描述',
                  labelStyle: TextStyle(
                    color: Colors.white70
                  )
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: defaultPadding),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final time = _dateController.text;
                    final endTime = _endTimeController.text;
                    final place = _placeController.text;
                    final description = _descriptionController.text;
                    final result = await AddSchedule(time,endTime, place, description);
                    await PromptDialog(context, result ? '添加成功' : '添加失败');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('提交'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}