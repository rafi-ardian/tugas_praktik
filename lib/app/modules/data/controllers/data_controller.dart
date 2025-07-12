// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class DataController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Rx<List<Map<String, dynamic>>> voters = Rx<List<Map<String, dynamic>>>(
//     [],
//   );

//   @override
//   void onInit() {
//     super.onInit();
//     _firestore.collection('voters').snapshots().listen((snapshot) {
//       voters.value = snapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var voters = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoters();
  }

  Future<void> fetchVoters() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('voters').get();
      voters.value =
          querySnapshot.docs.map((doc) {
            final data = doc.data();
            data['docId'] = doc.id; // Tambahkan docId ke dalam map
            return data;
          }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e');
    }
  }
}
