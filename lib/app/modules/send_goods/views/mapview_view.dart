import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:gojek_sederhana/app/modules/send_goods/controllers/send_goods_controller.dart';
import 'package:latlong2/latlong.dart';

class MapviewView extends GetView {
  const MapviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendGoodsController>(
      init: SendGoodsController(),
      builder: (sgCtrl) => FlutterMap(
          // mapController: _mapController,
          options: MapOptions(
              center: sgCtrl.state == 0
                  ? LatLng(sgCtrl.latDriv, sgCtrl.longDriv)
                  : LatLng(sgCtrl.latOfc, sgCtrl.longOfc),
              zoom: 13.0,
              onTap: sgCtrl.retPositionMap),
          children: [
            TileLayer(
              urlTemplate: dotenv.get('URL_MAPS'),
              additionalOptions: {
                'accessToken': dotenv.get('ACCESS_TOKEN'),
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: sgCtrl.state == 0
                      ? LatLng(sgCtrl.latDriv, sgCtrl.longDriv)
                      : LatLng(sgCtrl.latOfc, sgCtrl.longOfc),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
