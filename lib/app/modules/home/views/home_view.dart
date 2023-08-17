import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';
import 'package:gojek_sederhana/utils/themes/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Text(
                'Pengiriman Barang',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SEND_GOODS),
                    child: Container(
                      height: 160,
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.send_sharp,
                            color: CustomColor.mainGreen,
                            size: 60,
                          ),
                          const Text('Kirim Barang'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.HISTORY),
                    child: Container(
                      height: 160,
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.history,
                            color: CustomColor.mainGreen,
                            size: 60,
                          ),
                          const Text(
                            'History Kirim Barang',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
