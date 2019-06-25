import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sm_redux/modules/counter_global.dart';
import 'package:sm_redux/modules/counter_server.dart';
import 'package:sm_redux/modules/store.dart';

class AnotherScreen extends StatefulWidget {
  AnotherScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AnotherScreenState createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  @override
  initState() {
    super.initState();

    new Future.delayed(Duration.zero, () async {
      try {
        appStore.dispatch(LoadGlobalAction());

        Response response = await (new Dio()).get(
            'https://www.random.org/integers/?num=1&min=1&max=100&col=1&base=10&format=plain&rnd=new');

        appStore.dispatch(SuccessGlobalAction(int.parse(response.data)));
      } catch (e) {
        appStore.dispatch(ErrorGlobalAction('Internal server error.'));
      }
    });
  }

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
              'Loaded from the server:',
            ),
            new StoreConnector<AppState, CounterServerState>(
              converter: (store) => store.state.counterServer,
              builder: (context, CounterServerState counterServerState) {
                if (counterServerState.loading) {
                  return CircularProgressIndicator();
                }

                if (counterServerState.error != '') {
                  final error = counterServerState.error;
                  return Text(
                    '$error',
                    style: Theme.of(context).textTheme.display1,
                  );
                }

                final counterServerValue = counterServerState.data.toString();

                return Text(
                  '$counterServerValue',
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
          ],
        ),
      ),
      floatingActionButton: new StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          return () async {
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
