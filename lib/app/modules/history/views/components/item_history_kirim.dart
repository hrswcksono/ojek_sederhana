import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gojek_sederhana/app/data/models/send_good.dart';

import '../../../../../utils/themes/colors.dart';

class ItemHistoryKirim extends StatelessWidget {
  ItemHistoryKirim({
    super.key,
    required this.item,
  });

  final SendGood item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          border: Border.all(
              color: CustomColor.mainGreen,
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5)),
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.memory(base64.decode(item.image.split(',').last)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.distance} km'),
                    Text(item.date.substring(0, 10)),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Titik Driver'),
                        Text(
                            'Lat : ${item.latDriver.toString().substring(0, 2)},..'),
                        Text(
                            'Long : ${item.longDriver.toString().substring(0, 2)},..'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Titik Kantor'),
                        Text(
                            'Lat : ${item.latOffice.toString().substring(0, 2)},..'),
                        Text(
                            'Long : ${item.longOffice.toString().substring(0, 2)},..'),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
