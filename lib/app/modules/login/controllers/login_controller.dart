import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/profile.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';
import 'package:gojek_sederhana/service/db_helper.dart';

class LoginController extends GetxController {
  late TextEditingController nama;
  late TextEditingController password;

  @override
  void onInit() {
    nama = TextEditingController();
    password = TextEditingController();
    checkUser();
    super.onInit();
  }

  void checkUser() async {
    var temp = await DBHelper.instance.getUser();

    if (temp.isEmpty) {
      var data =
          Profile(id: 1, name: 'DRIVER 1', password: '1234', image: '', nik: 0);
      await DBHelper.instance.insertProfile(data);
    }

    print(temp);
  }

  void login() async {
    var data = await DBHelper.instance.getUser();

    if (data[0]['name'] == nama.text && data[0]['password'] == password.text) {
      print('benar');
      Get.toNamed(Routes.BASE);
    } else {
      print('salah');
    }

    print(data);
  }
}
