import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sm_redux/modules/counter_global.dart';
import 'package:sm_redux/modules/counter_local.dart';
import 'package:sm_redux/modules/store.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button (local):',
            ),
            new StoreConnector<AppState, String>(
              converter: (store) => store.state.counterLocal.toString(),
              builder: (context, count) {
                return new Text(
                  count,
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            Container(margin: EdgeInsets.only(top: 20.0)),
            Text(
              'You have pushed the button (global):',
            ),
            new StoreConnector<AppState, String>(
              converter: (store) => store.state.counterGlobal.toString(),
              builder: (context, count) {
                return new Text(
                  count,
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            Container(margin: EdgeInsets.only(top: 20.0)),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/another');
              },
              child: Text('Go to another screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: new StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          return () async {
            store.dispatch(IncrementCounterLocalAction());
            store.dispatch(IncrementCounterGlobalAction());
          };
        },
        builder: (context, callback) {
          return new FloatingActionButton(
            onPressed: callback,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
