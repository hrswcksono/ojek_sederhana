import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/profile.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';
import 'package:gojek_sederhana/service/db_helper.dart';

import '../../../../service/storage_service.dart';
import '../../../../utils/values/get_storage_key.dart';

class LoginController extends GetxController {
  late TextEditingController nama;
  late TextEditingController password;
  var getService = Get.put(StorageService());

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
      var data = Profile(
          id: 1,
          name: 'DRIVER 1',
          password: '1234',
          image: '',
          nik: 'Belum diisi');
      await DBHelper.instance.insertProfile(data);
    }
  }

  void login() async {
    if (nama.text.isEmpty || password.text.isEmpty) {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Username atau password tidak boleh kosong",
        ),
      );
      return;
    }
    var data = await DBHelper.instance.getUser();

    if (data[0]['name'] == nama.text && data[0]['password'] == password.text) {
      getService.write(GetStorageKey.isLogin, 'login');
      Get.toNamed(Routes.BASE);
    } else {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Username atau password salah",
        ),
      );
    }
  }
}
