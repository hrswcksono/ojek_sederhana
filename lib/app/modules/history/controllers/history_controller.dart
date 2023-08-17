import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../service/db_helper.dart';
import '../../../data/models/send_good.dart';

class HistoryController extends GetxController with StateMixin<List<SendGood>> {
  var sendgooddata = List<SendGood>.empty(growable: true);

  var focusedDay = DateTime.now();
  var calendarFormat = CalendarFormat.twoWeeks;
  var selectedDay = DateTime.now();

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
    if (sendgooddata.isEmpty) {
      change(null, status: RxStatus.empty());
    } else {
      change(sendgooddata, status: RxStatus.success());
    }
  }
}
