import 'package:address_list/component/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../GlobalVariable.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final List<String> _dialPad = [
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9',
    '*', '0', '#',
  ];
  String callNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // iOS深色主题
      child: CustomScrollView(
        slivers: [
          AppBarTool(currentIndexTitle: "通话"),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              height: 80,
              child: Text(
                  callNumber ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              ),
            ),

          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal:80),
            sliver: SliverGrid.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              children: _dialPad.map((String dial) {
                return GridTile(
                  child: Container(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:  MaterialStateProperty.all<Color>(Colors.white24),
                        shape: MaterialStateProperty.all(const StadiumBorder(
                            side: BorderSide(style: BorderStyle.none))),
                        //minimumSize: MaterialStateProperty.all<Size>(Size(18, 18)), // 设置按钮的最小尺寸
                        //maximumSize: MaterialStateProperty.all<Size>(Size(20, 20)), // 设置按钮的最大尺寸
                      ),
                      child: Text(
                        dial,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        String temp = (callNumber ?? "") + dial;
                        callNumber =  temp;
                        setState(() {});
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          //拨号键盘下面的按钮
          SliverToBoxAdapter(
            child: Container(
              height: 110,
              child: GridView(
                physics: NeverScrollableScrollPhysics(),   //无法滚动设置
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2, // 格子的宽高比例
                ),
                padding: EdgeInsets.only(top: 20.0),
                children: [
                  Container(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightGreen,
                    ),
                    child: IconButton(
                        onPressed: () => launch("tel:$callNumber"),
                        icon: Icon(
                          Icons.call,
                          color: Colors.white,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Colors.lightGreen,
                    ),
                    child: IconButton(
                      onPressed: (){
                        if(callNumber != "") {
                          callNumber = callNumber!.substring(0, callNumber!.length - 1);
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}