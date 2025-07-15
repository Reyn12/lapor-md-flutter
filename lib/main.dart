import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'utils/storage_utils.dart';

void main() async {

    // Pastikan Flutter binding udah ready dulu
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();

    // Tampil semua isi storage saat aplikasi pertama kali dijalankan
  print('\n=== [Debug Local Storage] ===');
  // StorageUtils.setValue('is_first_time', true);
  StorageUtils.printAllStorage();

  // Konfigurasi UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Kunci orientasi ke portrait saja
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
