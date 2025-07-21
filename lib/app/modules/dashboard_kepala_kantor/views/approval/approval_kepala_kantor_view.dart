import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_kepala_kantor_controller.dart';
import 'widgets/list_pengaduan_approval_card.dart';

class ApprovalKepalaKantorView extends StatelessWidget {
  const ApprovalKepalaKantorView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2196F3), // Blue
                  Color(0xFF1976D2), // Darker Blue
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Approval Kepala Kantor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                            'Selamat datang, ${controller.userName.value}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          )),
                    ],
                  ),
                ),


              ],
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingApproval.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.approvalData.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tidak ada pengaduan yang perlu approval',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.approvalData.length,
                itemBuilder: (context, index) {
                  final pengaduan = controller.approvalData[index];
                  return ListPengaduanApprovalCard(
                    pengaduan: pengaduan,
                    onAction: (id, action, catatan) {
                      _handleAction(controller, id, action, catatan);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _handleAction(DashboardKepalaKantorController controller, int id, String action, String? catatan) async {
    // Tampilkan loading dialog
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    
    try {
      Map<String, dynamic> result;
      
      if (action == 'approve') {
        // Untuk approve, catatan wajib diisi
        if (catatan == null || catatan.isEmpty) {
          // Tutup loading dialog
          Get.back();
          
          Get.snackbar(
            'Perhatian',
            'Catatan approval wajib diisi',
            backgroundColor: Colors.amber,
            colorText: Colors.white,
          );
          return;
        }
        result = await controller.approvePengaduan(id, catatan);
      } else {
        // Untuk reject, catatan opsional
        result = await controller.rejectPengaduan(id, catatan);
      }
      
      // Tutup loading dialog
      Get.back();
      
      // Tampilkan snackbar hasil
      Get.snackbar(
        result['success'] ? (action == 'approve' ? 'Berhasil' : 'Ditolak') : 'Gagal',
        result['message'],
        backgroundColor: result['success'] 
            ? (action == 'approve' ? Colors.green : Colors.red)
            : Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
    } catch (e) {
      // Tutup loading dialog
      Get.back();
      
      // Tampilkan error
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}