//import 'package:countingdaysloveyou/API_CARD/Screen/api_card.dart';
//import 'package:countingdaysloveyou/API_CARD/demo_listview.dart';
import 'package:countingdaysloveyou/app_state.dart';
import 'package:countingdaysloveyou/model/demo_data.dart';
import 'package:countingdaysloveyou/view/choose_date_time.dart';
import 'package:countingdaysloveyou/view/my_home_page.dart';
import 'package:countingdaysloveyou/view/optionDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState appState, dynamic action) {
  AppState newState = AppState.fromAppState(appState);
  if (action is DemoData) {
    newState.data = action.mdata;
  }
  return newState;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final _initState = AppState(data: "duong Quoc khanh");
  final Store<AppState> _store = Store(reducer, initialState: _initState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
	      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ChooseDateTime(title: 'Date Time'),
          '/myHome': (context) => MyHomePage(title: 'DEVK',),
          '/optionDetail': (context) => OptionDetail(title: 'InFor',),
        },
      ),
    );
  }
}
