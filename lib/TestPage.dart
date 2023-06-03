import 'package:address_list/mapper/ContactDataSynchronism.dart';
import 'package:flutter/material.dart';
import 'mapper/DataSource.dart';

class TestPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => TestPageState();
}

class TestPageState extends State<TestPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('save'),
              onPressed: () async {
                await SaveContactData();
              }
            ),
            ElevatedButton(
                onPressed: ()async{
                  await ReadContactDataFromDB();
                },
                child: Text('read')
            ),
            Keypad(),
          ],

      ),

    )
    );
  }
}
class Keypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(9, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // 处理按键逻辑
            },
            child: Text((index + 1).toString()),
          ),
        );
      }),
    );
  }
}