import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_controller.dart';

class InfoView extends GetView<InfoController> {
  const InfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
