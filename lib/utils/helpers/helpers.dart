import 'package:get_storage/get_storage.dart';

import '../values/get_storage_key.dart';

String readToken() {
  var result = GetStorage().read(GetStorageKey.isLogin);
  return (result != null) ? result : "";
}

void removeToken() {
  GetStorage().remove(GetStorageKey.isLogin);
}
