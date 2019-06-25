import 'package:redux/redux.dart';
import 'package:sm_redux/modules/counter_global.dart';
import 'package:sm_redux/modules/counter_local.dart';
import 'package:sm_redux/modules/counter_server.dart';

class AppState {
  final int counterLocal;
  final int counterGlobal;
  final CounterServerState counterServer;

  AppState(this.counterLocal, this.counterGlobal, this.counterServer);
}

AppState appStateReducer(AppState state, action) => new AppState(
      counterLocalReducer(state.counterLocal, action),
      counterGlobalReducer(state.counterGlobal, action),
      counterServerReducer(state.counterServer, action),
    );

final appStore = new Store<AppState>(appStateReducer,
    initialState: new AppState(0, 0, new CounterServerState(0, true, '')));
