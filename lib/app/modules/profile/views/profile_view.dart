import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width / 2.5,
                  height: Get.width / 2.5,
                  // child: Icon(CustomIcons.option, size: 20,),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFe0f2f1),
                  ),
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/2048px-Circle-icons-profile.svg.png'),
                ),
                const Row(
                  children: [
                    Text('Nama : '),
                    Text('Agus dsadasdsadasdsas'),
                  ],
                ),
                const Row(
                  children: [
                    Text('No KTP : '),
                    Text('894732894732832'),
                  ],
                ),
                const Row(
                  children: [
                    Text('Password : '),
                    Text('894732894732832'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
