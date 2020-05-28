import 'dart:async';
import 'dart:ui';
import 'package:countingdaysloveyou/view/animation/rainbow_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

double heights = MediaQueryData.fromWindow(window).size.height;
double widths = MediaQueryData.fromWindow(window).size.width;

class ChooseDateTime extends StatefulWidget {
  String title;
  ChooseDateTime({this.title});
  @override
  State<StatefulWidget> createState() => StateDateTime();
}

class StateDateTime extends State<ChooseDateTime>
    with SingleTickerProviderStateMixin {
  int _day;
  Timer _timer;
  String _date = "Not set";
  AnimationController controller;
  Animation<double> animation;
  bool mIscheck = false;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 10), () {
      controller =
          AnimationController(duration: Duration(seconds: 7), vsync: this);
      animation = Tween<double>(begin: -350, end: widths).animate(controller)
        ..addListener(
          () {
            setState(() {});
          },
        );
      controller.forward();
      mIscheck = true;
    });
    _getDataLocals();
  }

  _getDataLocals() async {
    final getTime = await SharedPreferences.getInstance();
    var _timestamp = getTime.getInt("@DATE_TIME");
    if (_timestamp != null) {
      DateTime _dueDate2 =
          DateTime.fromMicrosecondsSinceEpoch(_timestamp * 1000);
      final date2 = DateTime.now();
      final difference = date2.difference(_dueDate2).inDays;
      print("DEVK _timestamp: " + difference.toString());
      _day = difference;
      setState(() {});
    }
  }

  @override
  dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            iconSize: 35,
            onPressed: () => _setOnClickNextScreen(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () => _setOnClickShowDateTime(),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              Text(
                                " $_date",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            flex: 1,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/unnamed.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _day == null ? "Chon ngay" : _day.toString(),
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Codystar',
                        shadows: [
                          Shadow(
                            color: Colors.green,
                            blurRadius: 10.0,
                            offset: Offset(5.0, 5.0),
                          ),
                          Shadow(
                            color: Colors.red,
                            blurRadius: 10.0,
                            offset: Offset(-5.0, 5.0),
                          ),
                        ],
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.red[700],

                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: RainbowText(colors: [
                    Color(0xFFFF2B22),
                    Color(0xFFFF7F22),
                    Color(0xFFEDFF22),
                    Color(0xFF22FF22),
                    Color(0xFF22F4FF),
                    Color(0xFF5400F7),
                  ], text: "Welcome to BBT", loop: true,),
                  left: mIscheck ? animation.value : -350,
                )
              ],
            ),
            flex: 9,
          ),
        ],
      ),
    );
  }

  _setOnClickNextScreen(BuildContext context) {
    Navigator.pushNamed(context, '/myHome');
  }

  _setOnClickShowDateTime() async {
    DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(
        containerHeight: 210.0,
      ),
      showTitleActions: true,
      minTime: DateTime(2019, 07, 15),
      maxTime: DateTime(2050, 07, 15),
      onConfirm: (date) async {
        int timestamp = date.millisecondsSinceEpoch;
        final savedatelocal = await SharedPreferences.getInstance();
        savedatelocal.setInt("@DATE_TIME", timestamp);
        final date2 = DateTime.now();
        final difference = date2.difference(date).inDays;
        _day = difference;
        _date = '${date.year} - ${date.month} - ${date.day}';
        setState(() {});
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
