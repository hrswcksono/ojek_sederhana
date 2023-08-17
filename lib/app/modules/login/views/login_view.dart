import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              TextField(
                controller: controller.nama,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: controller.password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                child: const Text('Login'),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
