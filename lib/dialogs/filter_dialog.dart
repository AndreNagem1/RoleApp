import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  filter() {
    return SimpleDialog(
      title: const Text('Filtrar por Proximidade'),
      children: [
        Obx(
          () => Slider(
            value: MapController.to.raio.value,
            min: 0,
            max: 10,
            divisions: 10000,
            label: MapController.to.distancia,
            onChanged: (value) => MapController.to.raio.value = value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24, top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => MapController.to.filtrarCafes(),
                child: const Text('Filtrar'),
              ),
              TextButton(
                  onPressed: () => Get.back(), child: const Text('Cancelar')),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafés'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showDialog(context: context, builder: (context) => filter());
            },
          ),
        ],
      ),
      body: GetBuilder<MapController>(
        init: controller,
        builder: (value) => GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: controller.position,
            zoom: 13,
          ),
          onMapCreated: controller.onMapCreated,
          myLocationEnabled: true,
          markers: controller.markers,
        ),
      ),
    );
  }
}
