import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldSendGoods extends StatelessWidget {
  const TextFieldSendGoods({
    super.key,
    required this.title,
    required this.textEdt,
  });

  final String title;
  final TextEditingController textEdt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        SizedBox(
            width: Get.width * 0.3,
            child: TextField(
              controller: textEdt,
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
