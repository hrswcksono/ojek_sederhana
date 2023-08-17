import 'package:get/get.dart';

import '../controllers/send_goods_controller.dart';

class SendGoodsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendGoodsController>(
      () => SendGoodsController(),
    );
  }
}
