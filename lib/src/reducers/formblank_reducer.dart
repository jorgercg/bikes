import 'package:redux/redux.dart';

import '../actions/formblank_actions.dart';

final formblankReducer = combineReducers<bool>([
  TypedReducer<bool, SetFormDataIsBlank>(_setIsFormDataIsBlank),
]);

bool _setIsFormDataIsBlank(bool formDataIsBlank, action) {
  return action.formDataIsBlank;
}
