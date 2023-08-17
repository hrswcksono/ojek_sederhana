import 'package:get/get.dart';

import '../../../../service/db_helper.dart';
import '../../../data/models/send_good.dart';

class HistoryController extends GetxController with StateMixin<List<SendGood>> {
  var sendgooddata = List<SendGood>.empty(growable: true);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    await DBHelper.instance.getList().then((value) {
      for (var element in value) {
        sendgooddata.add(SendGood(
            id: element['id'],
            latDriver: element['latDriver'],
            longDriver: element['longDriver'],
            latOffice: element['latOffice'],
            longOffice: element['longOffice'],
            distance: element['distance'],
            image: element['image'],
            date: element['date']));
      }
    });
    change(sendgooddata, status: RxStatus.success());
  }
}
