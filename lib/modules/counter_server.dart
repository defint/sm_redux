import 'package:redux/redux.dart';

class CounterServerState {
  final bool loading;
  final String error;
  final int data;

  CounterServerState(this.data, this.loading, this.error);
}

class LoadGlobalAction {}

class SuccessGlobalAction {
  final int data;

  SuccessGlobalAction(this.data);
}

class ErrorGlobalAction {
  final String error;

  ErrorGlobalAction(this.error);
}

CounterServerState _loadReducer(
    CounterServerState state, LoadGlobalAction action) {
  return new CounterServerState(state.data, true, '');
}

CounterServerState _successReducer(
    CounterServerState state, SuccessGlobalAction action) {
  return new CounterServerState(action.data, false, '');
}

CounterServerState _errorReducer(
    CounterServerState state, ErrorGlobalAction action) {
  return new CounterServerState(state.data, false, action.error);
}

Reducer<CounterServerState> counterServerReducer =
    combineReducers<CounterServerState>([
  new TypedReducer<CounterServerState, LoadGlobalAction>(_loadReducer),
  new TypedReducer<CounterServerState, SuccessGlobalAction>(_successReducer),
  new TypedReducer<CounterServerState, ErrorGlobalAction>(_errorReducer),
]);
