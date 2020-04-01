import 'package:redux/redux.dart';

import '../actions/formmod_actions.dart';

final formmodReducer = combineReducers<bool>([
  TypedReducer<bool, SetFormDataIsModified>(_setIsFormDataIsModified),
]);

bool _setIsFormDataIsModified(bool formDataIsModified, action) {
  return action.formDataIsModified;
}
