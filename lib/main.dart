import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sm_redux/modules/store.dart';
import 'package:sm_redux/widgets/another_screen.dart';
import 'package:sm_redux/widgets/home_screen.dart';

void main() {
  runApp(new StoreProvider<AppState>(store: appStore, child: new SmReduxApp()));
}

class SmReduxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SM Redux',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.orange,
          accentColor: Colors.orangeAccent,
          buttonColor: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(title: 'Local + Global'),
        '/another': (context) => AnotherScreen(title: 'Local + Async'),
      },
    );
  }
}
