import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoListViews extends StatefulWidget {
  @override
  createState() => new HomeState();
}
class ModelList{
  String name;
  ModelList({this.name});
}
class HomeState extends State<DemoListViews> {
  ScrollController controller;
  List<ModelList> _all = [];
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isCheck = false;

  @override
  void initState() {
    super.initState();

    List<ModelList> arr = [];
    List<String> e = ['khanh', 'khai','han', 'tien','tam', 'nga', 'chi', 'hanh', 'tra', 'thuy', 'kieu'];
    for (int i = 0; i < e.length; i++) {
      arr.add(ModelList(name: e[i]));
    }
    print("DEVK itemCount: "+arr.toString());
    _all.addAll(arr);
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if(!isCheck){
        startLoader();
      }
    }
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      fetchData();
    });
  }

  fetchData() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, onResponse);
  }

  void onResponse() {
    List<ModelList> arr = [];
    List<String> e = ['vang', 'lam'];

    for (int i = 0; i < e.length; i++) {
      arr.add(ModelList(name: e[i]));
    }
    setState(() {
      isLoading = !isLoading;
      _all.addAll(arr);
    });
    print("DEVK onResponse: "+arr.toString());
    print("DEVK onResponse _all: "+_all.toString());
    if (_all.asMap().containsKey(11)) {
      print('Exists');
      setState(() {
        isCheck = true;
      });
    } else {
      print('Doesn\'t exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new Stack(
        children: <Widget>[
          _buildSuggestions(),
          _loader(),
        ],
      ),
    );
  }
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      controller: controller,
      itemCount: _all.length,
      itemBuilder: (context, index) {
        return _buildRow(_all[index].name);
      },
    );
  }
  Widget _buildRow(String index) {
    return ListTile(
      title: new Card(
        elevation: 5.0,
        child: new Container(
          alignment: Alignment.center,
          margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: new Text("$index"),
        ),
      ),
    );
  }
  Widget _loader() {
    return isLoading
        ? new Align(
            child: new Container(
              width: 70.0,
              height: 70.0,
              child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator()),
              ),
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        : new SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }
}
