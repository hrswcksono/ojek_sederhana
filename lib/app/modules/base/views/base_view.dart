import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gojek_sederhana/app/modules/home/views/home_view.dart';
import 'package:gojek_sederhana/app/modules/profile/views/profile_view.dart';
import 'package:gojek_sederhana/utils/themes/colors.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
        init: BaseController(),
        builder: (ctx) => Scaffold(
              body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text("Tekan sekali lagi untuk keluar"),
                ),
                child: IndexedStack(
                  index: ctx.tabIndex,
                  children: [
                    const HomeView(),
                    ProfileView(),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: Get.height * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  // selectedFontSize: 20,
                  selectedIconTheme:
                      IconThemeData(color: CustomColor.mainGreen, size: 22),
                  selectedItemColor: CustomColor.mainGreen,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  mouseCursor: SystemMouseCursors.grab,
                  iconSize: 20,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'Profile',
                    )
                  ],
                  currentIndex: ctx.tabIndex,
                  onTap: ctx.changeTabIndex,
                ),
              ),
            ));
  }
}
