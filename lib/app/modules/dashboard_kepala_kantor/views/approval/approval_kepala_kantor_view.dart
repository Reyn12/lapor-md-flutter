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

  void _handleAction(DashboardKepalaKantorController controller, int id, String action, String? catatan) {
    // TODO: Implementasi approve/reject pengaduan API call
    String message = action == 'approve' 
        ? 'Pengaduan berhasil disetujui' 
        : 'Pengaduan ditolak';
    
    Get.snackbar(
      action == 'approve' ? 'Berhasil' : 'Ditolak',
      message,
      backgroundColor: action == 'approve' ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
    
    // Refresh data setelah approve/reject
    controller.fetchApprovalData();
    
    print('Action: $action, ID: $id, Catatan: $catatan');
  }
}