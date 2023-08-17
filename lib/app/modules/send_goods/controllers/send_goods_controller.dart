import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/send_good.dart';
import 'package:gojek_sederhana/service/db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class SendGoodsController extends GetxController {
  late TextEditingController latDriver;
  late TextEditingController longDriver;
  late TextEditingController latOffice;
  late TextEditingController longOffice;

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
      var pickImage = await _picker.pickImage(source: ImageSource.camera);
      if (pickImage != null) {
        imageGoods = File(pickImage.path);
      }
      update();
    }
  }

  Future<String> imageToBase64(File imageFile) async {
    // convert image into file object

    // Read bytes from the file object
    Uint8List _bytes = await imageFile.readAsBytes();

    // base64 encode the bytes
    String _base64String = base64.encode(_bytes);

    return _base64String;
  }

  void getData() {
    DBHelper.instance.getList().then((value) {
      value.forEach((element) {
        print(element);
      });
    });
  }

  void addData() async {
    var imageInput = await imageToBase64(imageGoods!);
    var distance = const Distance();

    var lengthData = 0;
    await DBHelper.instance.getList().then((value) {
      lengthData = value.length;
    });

    final distancets = distance.as(
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
      date: DateTime.now().toString(),
    );

    await DBHelper.instance.insert(data);
    sendgooddata.insert(0, data);
  }

  void deleteTable() async {
    await DBHelper.instance.delete(5);
  }

  void clearTable() async {
    await DBHelper.instance.clearTable();
  }
}
