import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  FormView({super.key});

  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Entri Data')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'NIK'),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.nik.value = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nama'),
                onChanged: (value) => controller.nama.value = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'No. HP'),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.noHp.value = value,
              ),
              Row(
                children: [
                  Text('JK: '),
                  Obx(
                    () => Radio(
                      value: 'OL',
                      groupValue: controller.jk.value,
                      onChanged: (value) => controller.jk.value = value!,
                    ),
                  ),
                  Text('OL'),
                  Obx(
                    () => Radio(
                      value: 'OP',
                      groupValue: controller.jk.value,
                      onChanged: (value) => controller.jk.value = value!,
                    ),
                  ),
                  Text('OP'),
                ],
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.selectDate,
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Tanggal'),
                      controller: TextEditingController(
                        text: controller.tanggal.value,
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Alamat'),
                onChanged: (value) => controller.alamat.value = value,
              ),
              ElevatedButton(
                onPressed: controller.pickLocation,
                child: Text('Pilih Lokasi'),
              ),
              Obx(
                () =>
                    controller.location.value != null
                        ? Text(
                          'Lokasi: ${controller.location.value!.latitude}, ${controller.location.value!.longitude}',
                        )
                        : Text('Lokasi: Belum dipilih'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.pickImage,
                    child: Text('Ambil Foto'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.pickImageFromGallery,
                    child: Text('Galeri'),
                  ),
                ],
              ),
              Obx(
                () =>
                    controller.gambarPath.value != null
                        ? Image.file(
                          File(controller.gambarPath.value!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                        : SizedBox.shrink(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.saveData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ganti MapPickerView dengan flutter_map
class MapPickerView extends StatefulWidget {
  final LatLng initialPosition;

  MapPickerView({required this.initialPosition});

  @override
  _MapPickerViewState createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.initialPosition,
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName:
                    'com.tugaspraktik.tugas_praktik', // Ganti dengan package name aplikasi kamu
                // Hapus subdomains
              ),
              MarkerLayer(
                markers:
                    selectedLocation != null
                        ? [
                          Marker(
                            point: selectedLocation!,
                            width: 80.0,
                            height: 80.0,
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ]
                        : [],
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                if (selectedLocation != null) {
                  Get.back(result: selectedLocation);
                }
              },
              child: Text('Konfirmasi Lokasi'),
            ),
          ),
        ],
      ),
    );
  }
}
