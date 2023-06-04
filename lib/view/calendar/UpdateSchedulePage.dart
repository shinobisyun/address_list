import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/component/PromptDialog.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service/UpdateSchedule.dart';


class UpdateSchedulePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Schedule event;

  UpdateSchedulePage({super.key, required this.event}) {
    _dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(event.time));
    _endTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(event.endTime));
    _placeController.text = event.place;
    _descriptionController.text = event.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑日程'),
        backgroundColor: appbarBGColor,
      ),
      body: Container(
        color: bodyBGColor,
        padding: const EdgeInsets.all(defaultPadding * 2),
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
                    color: Colors.white70,
                  )
                ),
                style: TextStyle(color: Colors.white),
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
                      color: Colors.white70,
                    )
                ),
                style: TextStyle(color: Colors.white),
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
                cursorColor: Colors.greenAccent,
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
                cursorColor: Colors.greenAccent,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '描述',
                  labelStyle: TextStyle(
                    color: Colors.white70
                  )
                ),
              ),

              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final time = _dateController.text;
                    final endTime = _endTimeController.text;
                    final place = _placeController.text;
                    final description = _descriptionController.text;
                    final result = await UpdateSchedule(time,endTime, place, description, event.scheduleID);  // You need to implement this method
                    PromptDialog(context, result ? '修改成功' : '修改失败');
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