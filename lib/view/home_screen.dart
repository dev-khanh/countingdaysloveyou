import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => StateHomeScreen();
}
class StateHomeScreen extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(body:  Image.network(args));
  }
}