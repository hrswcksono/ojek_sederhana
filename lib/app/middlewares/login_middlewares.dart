import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';

import '../../utils/helpers/helpers.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (readToken().isNotEmpty) {
      return const RouteSettings(name: Routes.BASE);
    }
    return null;
  }
}
