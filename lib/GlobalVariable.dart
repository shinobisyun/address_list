import 'package:address_list/mapper/DataSource.dart';
import 'package:flutter/material.dart';

const Color loginAndSignupColor = Color(0xFF80AAEA);
const Color loginAndSignupLightColor = Color(0xFFF1E6FF);
const Color themeColor = Color(0xFF3B3B3B);
const Color themeLightColor = Color(0xFFCECECE);
const Color appbarBGColor = Colors.black87;
const Color bodyBGColor = Colors.black87;

const double defaultPadding = 16.0;

final mysql = MySql();
//String? connectResult = 'disconnected database';

int userID = 0;
String userPhoneNumber = '0';

class Contact{
  String name;
  String phoneNumber;
  String indexLetter;
  String remark;
  int contactID;
  Contact({required this.name,required this.phoneNumber,required this.indexLetter, this.remark = "", required this.contactID});
}

List<Contact>? contactList = [];
String? contactListPath;

class Schedule{
  String time;
  String endTime;
  String place;
  String description;
  int scheduleID;
  Schedule({required this.time, required this.endTime, this.place = "", required this.description, required this.scheduleID});
}

List<Schedule>? scheduleList = [];
String? scheduleListPath;

bool unacceptMessagesFromStranger = false;

enum AddContactResult {
  alreadyName,
  alreadyPhone,
  connectError,
  addError,
  addSuccess
}