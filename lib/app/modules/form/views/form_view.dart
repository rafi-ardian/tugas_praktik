import 'package:tugas_praktik/app/modules/form/views/widgets/form_view_widgets.dart';

import '../controllers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class FormView extends GetView<FormController> {
  FormView({super.key});

  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Form Entri Data',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[600]!, Colors.green[700]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_add_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data Calon Pemilih',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lengkapi semua informasi dengan benar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              // opacity: 0.9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Form Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormViewWidgets.buildSectionTitle('Informasi Pribadi'),
                    const SizedBox(height: 16),

                    FormViewWidgets.buildTextField(
                      label: 'NIK',
                      hint: 'Masukkan NIK',
                      icon: Icons.credit_card_outlined,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.nik.value = value,
                    ),

                    const SizedBox(height: 16),

                    FormViewWidgets.buildTextField(
                      label: 'Nama Lengkap',
                      hint: 'Masukkan nama lengkap',
                      icon: Icons.person_outline,
                      onChanged: (value) => controller.nama.value = value,
                    ),

                    const SizedBox(height: 16),

                    FormViewWidgets.buildTextField(
                      label: 'No. HP',
                      hint: 'Masukkan nomor HP',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => controller.noHp.value = value,
                    ),

                    const SizedBox(height: 20),

                    // Gender Selection
                    FormViewWidgets.buildSectionTitle('Jenis Kelamin'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => FormViewWidgets.buildGenderCard(
                              title: 'Laki-laki',
                              value: 'OL',
                              groupValue: controller.jk.value,
                              icon: Icons.male_outlined,
                              onChanged:
                                  (value) => controller.jk.value = value!,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () => FormViewWidgets.buildGenderCard(
                              title: 'Perempuan',
                              value: 'OP',
                              groupValue: controller.jk.value,
                              icon: Icons.female_outlined,
                              onChanged:
                                  (value) => controller.jk.value = value!,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Date Picker
                    Obx(
                      () => FormViewWidgets.buildDateField(
                        label: 'Tanggal',
                        value: controller.tanggal.value,
                        onTap: controller.selectDate,
                      ),
                    ),

                    const SizedBox(height: 16),

                    FormViewWidgets.buildTextField(
                      label: 'Alamat',
                      hint: 'Masukkan alamat lengkap',
                      icon: Icons.location_on_outlined,
                      maxLines: 3,
                      onChanged: (value) => controller.alamat.value = value,
                    ),

                    const SizedBox(height: 20),

                    // Location Section
                    FormViewWidgets.buildSectionTitle('Lokasi'),
                    const SizedBox(height: 12),
                    FormViewWidgets.buildActionButton(
                      title: 'Pilih Lokasi',
                      subtitle: 'Tentukan koordinat lokasi',
                      icon: Icons.map_outlined,
                      color: Colors.blue,
                      onPressed: controller.pickLocation,
                    ),

                    const SizedBox(height: 8),

                    Obx(
                      () =>
                          controller.location.value != null
                              ? FormViewWidgets.buildInfoCard(
                                title: 'Lokasi Terpilih',
                                content:
                                    'Lat: ${controller.location.value!.latitude.toStringAsFixed(6)}\nLon: ${controller.location.value!.longitude.toStringAsFixed(6)}',
                                icon: Icons.location_on,
                                color: Colors.green,
                              )
                              : FormViewWidgets.buildInfoCard(
                                title: 'Lokasi',
                                content: 'Belum dipilih',
                                icon: Icons.location_off,
                                color: Colors.grey,
                              ),
                    ),

                    const SizedBox(height: 20),

                    // Photo Section
                    FormViewWidgets.buildSectionTitle('Foto'),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: FormViewWidgets.buildActionButton(
                            title: 'Kamera',
                            subtitle: 'Ambil foto',
                            icon: Icons.camera_alt_outlined,
                            color: Colors.orange,
                            onPressed: controller.pickImage,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormViewWidgets.buildActionButton(
                            title: 'Galeri',
                            subtitle: 'Pilih dari galeri',
                            icon: Icons.photo_library_outlined,
                            color: Colors.purple,
                            onPressed: controller.pickImageFromGallery,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Photo Preview
                    Obx(
                      () =>
                          controller.gambarPath.value != null
                              ? Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(controller.gambarPath.value!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              : Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 48,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Belum ada foto',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),

                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.saveData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_outlined, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Simpan Data',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
