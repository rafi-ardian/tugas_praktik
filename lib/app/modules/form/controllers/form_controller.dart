import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_praktik/app/modules/form/views/widgets/map_picker_view.dart';
import 'package:tugas_praktik/app/modules/home/views/home_view.dart';

class FormController extends GetxController {
  var nik = ''.obs;
  var nama = ''.obs;
  var noHp = ''.obs;
  var jk = 'OL'.obs;
  var tanggal = ''.obs;
  var alamat = ''.obs;
  var gambarPath = Rx<String?>(null); // Nullable untuk preview
  var location = Rx<LatLng?>(null); // Koordinat dari peta

  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName =
            'voter_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final localPath = '${directory.path}/$fileName';
        await File(image.path).copy(localPath);
        gambarPath.value = localPath;
        Get.snackbar('Sukses', 'Gambar disimpan secara lokal');
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName =
            'voter_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final localPath = '${directory.path}/$fileName';
        await File(image.path).copy(localPath);
        gambarPath.value = localPath;
        Get.snackbar('Sukses', 'Gambar dari galeri disimpan');
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      tanggal.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> pickLocation() async {
    // Inisialisasi peta dengan posisi awal (misalnya Jakarta)
    LatLng initialPosition = LatLng(-6.1745, 106.8227); // Koordinat Jakarta
    LatLng? selectedLocation = await Get.to(
      () => MapPickerView(initialPosition: initialPosition),
    );
    if (selectedLocation != null) {
      location.value = selectedLocation;
      Get.snackbar(
        'Sukses',
        'Lokasi dipilih: ${selectedLocation.latitude}, ${selectedLocation.longitude}',
      );
    }
  }

  Future<void> saveData() async {
    try {
      if (nik.value.isEmpty) {
        Get.snackbar('Error', 'NIK harus diisi');
        return;
      }
      if (nama.value.isEmpty) {
        Get.snackbar('Error', 'Nama harus diisi');
        return;
      }
      if (noHp.value.isEmpty) {
        Get.snackbar('Error', 'No. HP harus diisi');
        return;
      }
      if (alamat.value.isEmpty) {
        Get.snackbar('Error', 'Alamat harus diisi');
        return;
      }
      if (tanggal.value.isEmpty) {
        Get.snackbar('Error', 'Tanggal harus diisi');
        return;
      }
      if (gambarPath.value == null) {
        Get.snackbar('Error', 'Gambar harus dipilih atau difoto');
        return;
      }
      if (location.value == null) {
        Get.snackbar('Error', 'Lokasi harus dipilih');
        return;
      }
      await _firestore.collection('voters').add({
        'nik': nik.value,
        'nama': nama.value,
        'noHp': noHp.value,
        'jk': jk.value,
        'tanggal': tanggal.value,
        'alamat': alamat.value,
        'gambarPath': gambarPath.value,
        'location': {
          'latitude': location.value!.latitude,
          'longitude': location.value!.longitude,
        },
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Sukses', 'Data berhasil disimpan');
      Get.offAll(HomeView());
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan data: $e');
    }
  }
}
