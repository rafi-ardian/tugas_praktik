import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_praktik/app/modules/data/views/data_view.dart';
import 'package:tugas_praktik/app/modules/form/views/form_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: ListView.builder(
        itemCount: controller.menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Icon(Icons.${controller.menuItems[index]['icon']}),
            title: Text(controller.menuItems[index]['title']!),
            onTap: () {
              if (index == 0) Get.to(InfoScreen());
              if (index == 1) Get.to(FormView());
              if (index == 2) Get.to(DataView());
              if (index == 3) Get.back();
            },
          );
        },
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informasi')),
      body: Center(child: Text('Informasi Pemilihan Umum')),
    );
  }
}
