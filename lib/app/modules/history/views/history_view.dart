import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gojek_sederhana/utils/themes/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/history_controller.dart';
import 'components/item_history_kirim.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Kirim Barang'),
        centerTitle: true,
        backgroundColor: CustomColor.mainGreen,
      ),
      body: Column(
        children: [
          GetBuilder<HistoryController>(
              init: HistoryController(),
              builder: (ctx) {
                return TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: controller.focusedDay,
                  calendarFormat: controller.calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(controller.selectedDay, selectedDay)) {
                      controller.selectedDay = selectedDay;
                      controller.focusedDay = focusedDay;
                      print(selectedDay);
                      controller.update();
                    }
                  },
                  onFormatChanged: (format) {
                    if (controller.calendarFormat != format) {
                      controller.calendarFormat = format;
                      controller.update();
                    }
                  },
                  onPageChanged: (focusedDay) {
                    controller.focusedDay = focusedDay;
                    controller.update();
                  },
                );
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: controller.obx((state) => ListView.separated(
                    shrinkWrap: true,
                    itemCount: state!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemHistoryKirim(
                        item: state[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
