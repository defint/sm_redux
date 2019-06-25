import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sm_redux/modules/counter_local.dart';
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

class FlutterReduxApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: title,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  'You have pushed the button this many times:',
                ),
                new StoreConnector<AppState, String>(
                  converter: (store) => store.state.counterLocal.toString(),
                  builder: (context, count) {
                    return new Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: new StoreConnector<AppState, VoidCallback>(
            converter: (store) {
              return () async {
                store.dispatch(IncrementCounterLocalAction());
                await new Future.delayed(const Duration(seconds: 1), () => "1");
                store.dispatch(IncrementCounterLocalAction());
              };
            },
            builder: (context, callback) {
              return new FloatingActionButton(
                // Attach the `callback` to the `onPressed` attribute
                onPressed: callback,
                tooltip: 'asdasdasd',
                child: new Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}
