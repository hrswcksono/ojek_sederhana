import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojek_sederhana/utils/themes/colors.dart';
import '../controllers/send_goods_controller.dart';
import 'components/text_field_send_goods.dart';

class SendGoodsView extends GetView<SendGoodsController> {
  const SendGoodsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kirim Barang'),
        centerTitle: true,
        backgroundColor: CustomColor.mainGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () => {Get.dialog(pickImageGood())},
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColor.mainGreen,
                        width: 1.5,
                        style: BorderStyle.solid),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: GetBuilder<SendGoodsController>(
                  init: SendGoodsController(),
                  builder: (ctx) {
                    return ctx.imageGoods == null
                        ? Icon(
                            Icons.image,
                            size: 40,
                            color: CustomColor.mainGreen,
                          )
                        : Image(
                            image: FileImage(ctx.imageGoods!),
                            fit: BoxFit.cover,
                          );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Titik Driver'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldSendGoods(
                    title: 'latitude', textEdt: controller.latDriver),
                TextFieldSendGoods(
                    title: 'longitude', textEdt: controller.longDriver),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Titik Kantor'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldSendGoods(
                    title: 'latitude', textEdt: controller.latOffice),
                TextFieldSendGoods(
                    title: 'longitude', textEdt: controller.longOffice),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width * 0.35,
              child: ElevatedButton(
                  onPressed: () {
                    controller.getData();
                  },
                  child: const Text('Cek Jarak')),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width * 0.35,
              child: ElevatedButton(
                  onPressed: () {
                    controller.addData();
                  },
                  child: const Text('Kirim')),
            ),
          ],
        ),
      ),
    );
  }

  Column pickImageGood() {
    return Column(
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
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.addImage('c');
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
                      controller.addImage('g');
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
    );
  }
}
