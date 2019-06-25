import 'package:redux/redux.dart';

class IncrementCounterGlobalAction {}

int _incrementReducer(int state, IncrementCounterGlobalAction action) {
  return state + 1;
}

Reducer<int> counterGlobalReducer = combineReducers<int>([
  new TypedReducer<int, IncrementCounterGlobalAction>(_incrementReducer),
]);
