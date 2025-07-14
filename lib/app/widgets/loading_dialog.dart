import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Buat pakai Get.dialog dan Get.back
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Variable untuk tracking apakah loading sedang ditampilkan
bool _isLoadingShown = false;

// Fungsi untuk menampilkan loading
void showLoading() {
  if (_isLoadingShown) return; // Hindari multiple dialog

  _isLoadingShown = true;

  Get.dialog(
    WillPopScope(
      onWillPop: () async => false, // Biar gak bisa ditutup pakai tombol back
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.blue[200]!, // Warna animasi
          size: 50, // Ukuran animasi
        ),
      ),
    ),
    barrierDismissible: false, // Biar gak bisa diklik di luar area loading
    name: 'loading_dialog', // Kasih nama biar bisa dicari
  );
}

// Fungsi untuk menyembunyikan loading
void hideLoading() {
  // Tutup semua dialog untuk memastikan loading dialog tertutup
  if (Get.isDialogOpen == true) {
    Get.until((route) {
      return !(Get.isDialogOpen ?? false);
    });
  }

  _isLoadingShown = false;
}
