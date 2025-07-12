import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_praktik/app/modules/detail/views/detail_view.dart';
import '../controllers/data_controller.dart';

// class DataView extends GetView<DataController> {
//   DataView({super.key});

//   final DataController controller = Get.put(DataController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           'Data Pemilih',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black87),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: Colors.grey[200]),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh_outlined),
//             onPressed: () {
//               // Trigger refresh if needed
//               Get.snackbar(
//                 'Refresh',
//                 'Data sedang dimuat ulang',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.blue[600],
//                 colorText: Colors.white,
//                 duration: const Duration(seconds: 2),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header Statistics
//           Container(
//             margin: const EdgeInsets.all(20),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.orange[600]!, Colors.orange[700]!],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.orange.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.people_outline,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Total Pemilih',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Obx(
//                         () => Text(
//                           '${controller.voters.value.length} Orang',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Data List
//           Expanded(
//             child: Obx(() {
//               if (controller.voters.value.isEmpty) {
//                 return _buildEmptyState();
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: controller.voters.value.length,
//                 itemBuilder: (context, index) {
//                   final voter = controller.voters.value[index];
//                   return _buildVoterCard(voter, index);
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVoterCard(Map<String, dynamic> voter, int index) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(
//           () => DetailView(),
//           arguments: {
//             'docId':
//                 controller
//                     .voters
//                     .value[index]
//                     .id, // Asumsi doc.id dari snapshot
//             'nik': voter['nik'],
//             'nama': voter['nama'],
//             'noHp': voter['noHp'],
//             'jk': voter['jk'],
//             'tanggal': voter['tanggal'],
//             'alamat': voter['alamat'],
//             'gambarPath': voter['gambarPath'],
//             'location': voter['location'],
//           },
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             children: [
//               // Profile Picture or Avatar
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.grey[100],
//                 ),
//                 child:
//                     voter['gambarPath'] != null &&
//                             voter['gambarPath'].isNotEmpty
//                         ? ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.file(
//                             File(voter['gambarPath']),
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                         : Container(
//                           decoration: BoxDecoration(
//                             color: _getAvatarColor(index),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Icon(
//                             Icons.person,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//               ),

//               const SizedBox(width: 16),

//               // Voter Information
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Name and Gender
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             voter['nama'] ?? 'Nama tidak tersedia',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                         _buildGenderBadge(voter['jk']),
//                       ],
//                     ),

//                     const SizedBox(height: 8),

//                     // NIK
//                     _buildInfoRow(
//                       icon: Icons.credit_card_outlined,
//                       label: 'NIK',
//                       value: voter['nik'] ?? 'Tidak tersedia',
//                     ),

//                     const SizedBox(height: 4),

//                     // Phone Number
//                     _buildInfoRow(
//                       icon: Icons.phone_outlined,
//                       label: 'No. HP',
//                       value: voter['noHp'] ?? 'Tidak tersedia',
//                     ),

//                     const SizedBox(height: 4),

//                     // Birth Date
//                     _buildInfoRow(
//                       icon: Icons.calendar_today_outlined,
//                       label: 'Tanggal Lahir',
//                       value: voter['tanggal'] ?? 'Tidak tersedia',
//                     ),

//                     const SizedBox(height: 8),

//                     // Address
//                     if (voter['alamat'] != null && voter['alamat'].isNotEmpty)
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[50],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.location_on_outlined,
//                               size: 16,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 voter['alamat'],
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[600],
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                     const SizedBox(height: 8),

//                     // Location coordinates
//                     // if (voter['location'] != null)
//                     // Container(
//                     //   padding: const EdgeInsets.all(8),
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.blue[50],
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       Icon(
//                     //         Icons.gps_fixed,
//                     //         size: 14,
//                     //         color: Colors.blue[600],
//                     //       ),
//                     //       const SizedBox(width: 6),
//                     //       // Expanded(
//                     //       //   child: Text(
//                     //       //     'Lat: ${voter['location']['latitude']?.toStringAsFixed(4) ?? 'N/A'}, '
//                     //       //     'Lon: ${voter['location']['longitude']?.toStringAsFixed(4) ?? 'N/A'}',
//                     //       //     style: TextStyle(
//                     //       //       fontSize: 11,
//                     //       //       color: Colors.blue[600],
//                     //       //       fontWeight: FontWeight.w500,
//                     //       //     ),
//                     //       //   ),
//                     //       // ),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: Colors.grey[600]),
//         const SizedBox(width: 6),
//         Text(
//           '$label: ',
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(fontSize: 12, color: Colors.black87),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGenderBadge(String? gender) {
//     if (gender == null) return const SizedBox.shrink();

//     final isMale = gender == 'OL';
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: isMale ? Colors.blue[100] : Colors.pink[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             isMale ? Icons.male : Icons.female,
//             size: 12,
//             color: isMale ? Colors.blue[600] : Colors.pink[600],
//           ),
//           const SizedBox(width: 4),
//           Text(
//             isMale ? 'L' : 'P',
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: isMale ? Colors.blue[600] : Colors.pink[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getAvatarColor(int index) {
//     final colors = [
//       Colors.blue[600]!,
//       Colors.green[600]!,
//       Colors.orange[600]!,
//       Colors.purple[600]!,
//       Colors.red[600]!,
//       Colors.teal[600]!,
//     ];
//     return colors[index % colors.length];
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(
//                 Icons.people_outline,
//                 size: 64,
//                 color: Colors.grey[400],
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Belum Ada Data Pemilih',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Silakan tambahkan data pemilih melalui form entri data',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: () => Get.back(),
//               icon: const Icon(Icons.arrow_back_outlined, size: 18),
//               label: const Text('Kembali'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[600],
//                 foregroundColor: Colors.white,
//                 elevation: 0,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 12,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DataView extends GetView<DataController> {
  DataView({super.key});

  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Data Pemilih',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey[200]),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              controller.fetchVoters(); // Refresh data
              Get.snackbar(
                'Refresh',
                'Data sedang dimuat ulang',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue[600],
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Statistics
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[600]!, Colors.orange[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.people_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Pemilih',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          '${controller.voters.value.length} Orang',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Data List
          Expanded(
            child: Obx(() {
              if (controller.voters.value.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.voters.value.length,
                itemBuilder: (context, index) {
                  final voter = controller.voters.value[index];
                  return _buildVoterCard(voter, index);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCard(Map<String, dynamic> voter, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailView(),
          arguments: {
            'docId': voter['docId'], // Gunakan 'docId' dari map voter
            'nik': voter['nik'],
            'nama': voter['nama'],
            'noHp': voter['noHp'],
            'jk': voter['jk'],
            'tanggal': voter['tanggal'],
            'alamat': voter['alamat'],
            'gambarPath': voter['gambarPath'],
            'location': voter['location'],
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Profile Picture or Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child:
                    voter['gambarPath'] != null &&
                            voter['gambarPath'].isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(voter['gambarPath']),
                            fit: BoxFit.cover,
                          ),
                        )
                        : Container(
                          decoration: BoxDecoration(
                            color: _getAvatarColor(index),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
              ),
              const SizedBox(width: 16),
              // Voter Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Gender
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            voter['nama'] ?? 'Nama tidak tersedia',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        _buildGenderBadge(voter['jk']),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // NIK
                    _buildInfoRow(
                      icon: Icons.credit_card_outlined,
                      label: 'NIK',
                      value: voter['nik'] ?? 'Tidak tersedia',
                    ),
                    const SizedBox(height: 4),
                    // Phone Number
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'No. HP',
                      value: voter['noHp'] ?? 'Tidak tersedia',
                    ),
                    const SizedBox(height: 4),
                    // Birth Date
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Tanggal Lahir',
                      value: voter['tanggal'] ?? 'Tidak tersedia',
                    ),
                    const SizedBox(height: 8),
                    // Address
                    if (voter['alamat'] != null && voter['alamat'].isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                voter['alamat'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderBadge(String? gender) {
    if (gender == null) return const SizedBox.shrink();
    final isMale = gender == 'OL';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isMale ? Colors.blue[100] : Colors.pink[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMale ? Icons.male : Icons.female,
            size: 12,
            color: isMale ? Colors.blue[600] : Colors.pink[600],
          ),
          const SizedBox(width: 4),
          Text(
            isMale ? 'L' : 'P',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isMale ? Colors.blue[600] : Colors.pink[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAvatarColor(int index) {
    final colors = [
      Colors.blue[600]!,
      Colors.green[600]!,
      Colors.orange[600]!,
      Colors.purple[600]!,
      Colors.red[600]!,
      Colors.teal[600]!,
    ];
    return colors[index % colors.length];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.people_outline,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum Ada Data Pemilih',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Silakan tambahkan data pemilih melalui form entri data',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_outlined, size: 18),
              label: const Text('Kembali'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
