import 'package:tugas_praktik/app/modules/form/views/widgets/map_picker_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as devtools;
import 'package:get/get.dart';
import 'dart:io';

class DetailController extends GetxController {
  var nik = ''.obs;
  var nama = ''.obs;
  var noHp = ''.obs;
  var jk = 'OL'.obs;
  var tanggal = ''.obs;
  var alamat = ''.obs;
  var gambarPath = Rx<String?>(null);
  var location = Rx<LatLng?>(null);
  var isLoading = false.obs;
  var isDeleting = false.obs;
  var isDeletionComplete = false.obs;
  String? docId;

  final nikController = TextEditingController();
  final namaController = TextEditingController();
  final noHpController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      docId = args['docId'];
      nik.value = args['nik'] ?? '';
      nama.value = args['nama'] ?? '';
      noHp.value = args['noHp'] ?? '';
      jk.value = args['jk'] ?? 'OL';
      tanggal.value = args['tanggal'] ?? '';
      alamat.value = args['alamat'] ?? '';
      gambarPath.value = args['gambarPath'];

      devtools.log(
        'Location data: ${args['location']?.runtimeType} - ${args['location']}',
      );

      if (args['location'] != null) {
        try {
          if (args['location'] is Map<String, dynamic>) {
            final latitude =
                double.tryParse(args['location']['latitude'].toString()) ?? 0.0;
            final longitude =
                double.tryParse(args['location']['longitude'].toString()) ??
                0.0;
            location.value = LatLng(latitude, longitude);
          } else if (args['location'] is String) {
            final coords = args['location'].split(',');
            if (coords.length == 2) {
              final latitude = double.tryParse(coords[0].trim()) ?? 0.0;
              final longitude = double.tryParse(coords[1].trim()) ?? 0.0;
              location.value = LatLng(latitude, longitude);
            }
          }
        } catch (e) {
          devtools.log('Error parsing location: $e');
          location.value = null;
        }
      }

      nikController.text = nik.value;
      namaController.text = nama.value;
      noHpController.text = noHp.value;
      alamatController.text = alamat.value;
    }
  }

  @override
  void dispose() {
    nikController.dispose();
    namaController.dispose();
    noHpController.dispose();
    alamatController.dispose();
    super.dispose();
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

  Future<void> pickImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
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
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
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
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> pickLocation() async {
    LatLng initialPosition = location.value ?? LatLng(-6.1745, 106.8227);
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

  Future<void> updateData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      if (nikController.text.isEmpty) {
        Get.snackbar('Error', 'NIK harus diisi');
        return;
      }
      if (namaController.text.isEmpty) {
        Get.snackbar('Error', 'Nama Lengkap harus diisi');
        return;
      }
      if (noHpController.text.isEmpty) {
        Get.snackbar('Error', 'No. HP harus diisi');
        return;
      }
      if (alamatController.text.isEmpty) {
        Get.snackbar('Error', 'Alamat harus diisi');
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

      if (docId != null) {
        await FirebaseFirestore.instance.collection('voters').doc(docId).update(
          {
            'nik': nikController.text,
            'nama': namaController.text,
            'noHp': noHpController.text,
            'jk': jk.value,
            'tanggal': tanggal.value,
            'alamat': alamatController.text,
            'gambarPath': gambarPath.value,
            'location':
                location.value != null
                    ? {
                      'latitude': location.value!.latitude,
                      'longitude': location.value!.longitude,
                    }
                    : null,
            'timestamp': FieldValue.serverTimestamp(),
          },
        );
        Get.snackbar('Sukses', 'Data diperbarui');
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteData() async {
    if (isDeleting.value) return;
    isDeleting.value = true;
    try {
      if (docId != null) {
        await FirebaseFirestore.instance
            .collection('voters')
            .doc(docId)
            .delete();
        print("Data deleted");

        if (Get.context != null) {
          Get.snackbar(
            'Sukses',
            'Data dihapus',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          isDeletionComplete.value = true;
        } else {
          print("No context available for Get.snackbar or Get.back");
        }
      }
    } catch (e) {
      print("Error delete data: $e");
      if (Get.context != null) {
        Get.snackbar('Error', 'Gagal menghapus data: $e');
      } else {
        print("No context available to show error snackbar");
      }
    } finally {
      isDeleting.value = false;
    }
  }
}
