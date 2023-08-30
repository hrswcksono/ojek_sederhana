import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/app/data/models/send_good.dart';
import 'package:gojek_sederhana/app/modules/send_goods/views/mapview_view.dart';
import 'package:gojek_sederhana/service/db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class SendGoodsController extends GetxController {
  double latDriv = -7.6191793;
  double longDriv = 112.0118669;
  double latOfc = -7.6191793;
  double longOfc = 112.0118669;
  int state = 0;

  var distance = const Distance();

  var distancets = 0.0;

  var sendgooddata = List<SendGood>.empty(growable: true);

  File? imageGoods;
  final ImagePicker _picker = ImagePicker();

  void toMaps(int stt) {
    state = stt;
    update();
    Get.to(() => const MapviewView());
  }

  void retPositionMap(_, LatLng direct) {
    if (state == 0) {
      latDriv = direct.latitude;
      longDriv = direct.longitude;
    } else {
      latOfc = direct.latitude;
      longOfc = direct.longitude;
    }
    update();
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

  void showDistance() {
    distancets = distance.as(LengthUnit.Kilometer, LatLng(latDriv, longDriv),
        LatLng(latOfc, longOfc));
    update();
  }

  void refreshData() {
    Get.back();
  }

  void addData() async {
    var imageInput = await imageToBase64(imageGoods!);

    var lengthData = 0;

    await DBHelper.instance.getList().then((value) {
      lengthData = value.length;
    });

    distancets = distance.as(LengthUnit.Kilometer, LatLng(latDriv, longDriv),
        LatLng(latOfc, longOfc));

    var data = SendGood(
      id: lengthData,
      latDriver: latDriv,
      longDriver: longDriv,
      latOffice: latOfc,
      longOffice: longOfc,
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
