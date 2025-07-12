import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';

class DataView extends GetView<DataController> {
  DataView({super.key});

  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Pemilih')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.voters.value.length,
          itemBuilder: (context, index) {
            final voter = controller.voters.value[index];
            return ListTile(
              title: Text('Nama: ${voter['nama']}'),
              subtitle: Text('NIK: ${voter['nik']}'),
              trailing:
                  voter['gambarPath'] != null && voter['gambarPath'].isNotEmpty
                      ? Image.file(
                        File(voter['gambarPath']),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                      : null,
            );
          },
        ),
      ),
    );
  }
}
