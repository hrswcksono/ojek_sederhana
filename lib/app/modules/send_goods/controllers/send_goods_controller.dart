import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/send_good.dart';
import 'package:gojek_sederhana/service/db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class SendGoodsController extends GetxController {
  late TextEditingController latDriver;
  late TextEditingController longDriver;
  late TextEditingController latOffice;
  late TextEditingController longOffice;

  var distance = const Distance();

  var distancets = 0.0;

  var sendgooddata = List<SendGood>.empty(growable: true);

  File? imageGoods;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    latDriver = TextEditingController();
    longDriver = TextEditingController();
    latOffice = TextEditingController();
    longOffice = TextEditingController();
    super.onInit();
  }

  addImage(String label) async {
    if (label == "g") {
      var pickImage = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);
      if (pickImage != null) {
        imageGoods = File(pickImage.path);
      }
      update();
    } else if (label == "c") {
      var pickImage = await _picker.pickImage(
          source: ImageSource.camera, maxWidth: 200, maxHeight: 200);
      if (pickImage != null) {
        imageGoods = File(pickImage.path);
      }
      update();
    }
  }

  Future<String> imageToBase64(File imageFile) async {
    Uint8List bytes = await imageFile.readAsBytes();
    String base64String = base64.encode(bytes);
    return base64String;
  }

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool checkIsNumber() {
    if (isNumeric(latDriver.text) &&
        isNumeric(longDriver.text) &&
        isNumeric(latOffice.text) &&
        isNumeric(longOffice.text)) {
      return true;
    } else {
      return false;
    }
  }

  void verifDistance() {
    if (!checkIsNumber()) {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Masukkan hanya angka",
        ),
      );
      return;
    }
  }

  void showDistance() {
    if (latDriver.text.isEmpty ||
        longDriver.text.isEmpty ||
        latOffice.text.isEmpty ||
        longOffice.text.isEmpty) {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Lengkapi longitude latitude",
        ),
      );
      return;
    }
    verifDistance();
    distancets = distance.as(
        LengthUnit.Kilometer,
        LatLng(double.parse(latDriver.text), double.parse(longDriver.text)),
        LatLng(double.parse(latOffice.text), double.parse(longOffice.text)));
    update();
  }

  void refreshData() {
    Get.back();
  }

  void addData() async {
    if (imageGoods == null ||
        latDriver.text.isEmpty ||
        longDriver.text.isEmpty ||
        latOffice.text.isEmpty ||
        longOffice.text.isEmpty) {
      ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Tidak bolah ada yang kosong",
        ),
      );
      return;
    }

    verifDistance();
    var imageInput = await imageToBase64(imageGoods!);

    var lengthData = 0;

    await DBHelper.instance.getList().then((value) {
      lengthData = value.length;
    });

    distancets = distance.as(
        LengthUnit.Kilometer,
        LatLng(double.parse(latDriver.text), double.parse(longDriver.text)),
        LatLng(double.parse(latOffice.text), double.parse(longOffice.text)));

    var data = SendGood(
      id: lengthData,
      latDriver: double.parse(latDriver.text),
      longDriver: double.parse(longDriver.text),
      latOffice: double.parse(latOffice.text),
      longOffice: double.parse(longOffice.text),
      distance: distancets,
      image: imageInput,
      date: getDate(DateTime.now()),
    );

    await DBHelper.instance.insert(data);
    refreshData();
    ArtSweetAlert.show(
      context: Get.context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: "Success",
        text: "Sedang mengirim barang",
      ),
    );
  }

  String getDate(DateTime input) {
    return DateFormat("dd-MM-yyyy").format(input);
  }
}
