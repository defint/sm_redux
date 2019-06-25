import 'package:redux/redux.dart';

class IncrementCounterLocalAction {}

int _incrementReducer(int state, IncrementCounterLocalAction action) {
  return state + 1;
}

Reducer<int> counterLocalReducer = combineReducers<int>([
  new TypedReducer<int, IncrementCounterLocalAction>(_incrementReducer),
]);
