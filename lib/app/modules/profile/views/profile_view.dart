import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gojek_sederhana/app/routes/app_pages.dart';
import 'package:gojek_sederhana/utils/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/profile.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  var profileC = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: profileC.obx((state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        // ignore: unnecessary_null_comparison
                        state!.image == null
                            ? Container(
                                width: Get.width / 2.5,
                                height: Get.width / 2.5,
                                // child: Icon(CustomIcons.option, size: 20,),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/2048px-Circle-icons-profile.svg.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(
                                width: Get.width / 2.5,
                                height: Get.width / 2.5,
                                // child: Icon(CustomIcons.option, size: 20,),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: MemoryImage(base64
                                        .decode(state.image.split(',').last)),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () => Get.dialog(editImage(state)),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomColor.mainGreen,
                              ),
                              child: const Icon(
                                Icons.edit_square,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Nama : ${state.name}',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'No KTP : ${state.nik}',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Text('Password : '),
                    // Text('894732894732832')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => Get.dialog(editProfile(state)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.edit_document,
                                color: CustomColor.mainGreen,
                                size: 30,
                              ),
                              const Text('Edit Profile'),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.dialog(editPassword(state)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                color: CustomColor.mainGreen,
                                size: 30,
                              ),
                              const Text('Edit Password'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: Text('Keluar'))
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Column editImage(Profile data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            height: Get.height * 0.4,
            width: Get.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Edit Gambar',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (ctx) {
                    return ctx.imageProfile == null
                        ? Container(
                            width: Get.width / 2.5,
                            height: Get.width / 2.5,
                            // child: Icon(CustomIcons.option, size: 20,),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/2048px-Circle-icons-profile.svg.png'))),
                          )
                        : Container(
                            width: Get.width / 2.5,
                            height: Get.width / 2.5,
                            // child: Icon(CustomIcons.option, size: 20,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(ctx.imageProfile!))),
                          );
                  },
                ),
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (ctx) {
                    return ctx.imageProfile == null
                        ? ElevatedButton(
                            onPressed: () {
                              Get.dialog(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      height: 100,
                                      width: Get.width * 0.8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: CustomColor.mainGreen,
                                              width: 1.5,
                                              style: BorderStyle.solid),
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                                profileC.addImage('c');
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                size: 35,
                                              )),
                                          VerticalDivider(
                                            color: CustomColor.mainGreen,
                                            thickness: 2,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                                profileC.addImage('g');
                                              },
                                              icon: const Icon(
                                                Icons.filter_sharp,
                                                size: 35,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ));
                            },
                            child: const Text("Ambil Gambar"))
                        : ElevatedButton(
                            onPressed: () {
                              ctx.editImage(data);
                            },
                            child: const Text('Selesai'));
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column editProfile(Profile data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            height: Get.height * 0.4,
            width: Get.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Edit Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: profileC.namaTf,
                  decoration: const InputDecoration(hintText: 'Nama'),
                ),
                TextField(
                  controller: profileC.nikTf,
                  decoration: const InputDecoration(hintText: 'No KTP'),
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.editProfile(data);
                    },
                    child: const Text("Selesai"))
              ],
            ),
          ),
        )
      ],
    );
  }

  Column editPassword(Profile data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            height: Get.height * 0.4,
            width: Get.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Edit Password',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: profileC.passTf,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                TextField(
                  controller: profileC.confPassTf,
                  decoration:
                      const InputDecoration(hintText: 'Confirm Password'),
                ),
                ElevatedButton(
                    onPressed: () {
                      profileC.editPassword(data);
                    },
                    child: const Text("Selesai"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
