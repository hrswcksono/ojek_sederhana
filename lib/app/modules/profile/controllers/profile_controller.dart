import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/profile.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../service/db_helper.dart';
import '../../../../utils/helpers/helpers.dart';

class ProfileController extends GetxController with StateMixin<Profile> {
  late TextEditingController namaTf;
  late TextEditingController nikTf;

  late TextEditingController passTf;
  late TextEditingController confPassTf;

  File? imageProfile;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    namaTf = TextEditingController();
    nikTf = TextEditingController();
    passTf = TextEditingController();
    confPassTf = TextEditingController();
    initData();
    super.onInit();
  }

  void initData() async {
    var data = await DBHelper.instance.getUser();

    var dataProfile = Profile(
        id: data[0]['id'],
        name: data[0]['name'],
        password: data[0]['password'],
        image: data[0]['image'],
        nik: data[0]['nik']);

    change(dataProfile, status: RxStatus.success());
  }

  void editProfile(Profile data) async {
    if (namaTf.text.isNotEmpty && nikTf.text.isNotEmpty) {
      data.name = namaTf.text;
      data.nik = nikTf.text;
      await DBHelper.instance.editProfile(data);
      namaTf.clear();
      nikTf.clear();
      initData();
      Get.back();
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Success",
          text: "Berhasil mengganti profile",
        ),
      );
    } else {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Error",
          text: "Tidak boleh kosong",
        ),
      );
    }
  }

  void editPassword(Profile data) async {
    if (passTf.text == confPassTf.text) {
      data.password = passTf.text;
      await DBHelper.instance.editProfile(data);
      passTf.clear();
      confPassTf.clear();
      Get.back();
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Success",
          text: "Berhasil mengganti password",
        ),
      );
    } else {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Error",
          text: "Password tidak sama",
        ),
      );
    }
  }

  void editImage(Profile data) async {
    var imageInput = await imageToBase64(imageProfile!);
    data.image = imageInput;
    await DBHelper.instance.editProfile(data);
    initData();
    imageProfile = null;
    Get.back();
    update();
  }

  Future<String> imageToBase64(File imageFile) async {
    // convert image into file object
    // Read bytes from the file object
    Uint8List bytes = await imageFile.readAsBytes();
    // base64 encode the bytes
    String base64String = base64.encode(bytes);
    return base64String;
  }

  addImage(String label) async {
    if (label == "g") {
      var pickImage = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);
      if (pickImage != null) {
        imageProfile = File(pickImage.path);
      }
      update();
    } else if (label == "c") {
      var pickImage = await _picker.pickImage(
          source: ImageSource.camera, maxWidth: 200, maxHeight: 200);
      if (pickImage != null) {
        imageProfile = File(pickImage.path);
      }
      update();
    }
  }

  void logout() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You want to logout?",
            confirmButtonText: "Logout",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      Future.delayed(const Duration(seconds: 2), () {
        removeToken();
        Get.offAllNamed(Routes.LOGIN);
        return;
      });
    }
  }
}
