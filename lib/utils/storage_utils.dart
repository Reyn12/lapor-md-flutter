import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static final GetStorage _box = GetStorage();

  /// Print semua key dan value yang ada di GetStorage
  static void printAllStorage() {
    final keys = _box.getKeys().cast<String>();
    print('\n=== ISI GET STORAGE ===');
    if (keys.isEmpty) {
      print('Storage kosong');
    } else {
      for (var key in keys) {
        final value = _box.read(key);
        print('$key: $value (${value?.runtimeType})');
      }
    }
    print('========================\n');
  }

  static void printSpesificKey(String key) {
    final value = _box.read(key);
    print('$key: $value (${value?.runtimeType})');
  }

  /// Dapetin semua data dlm bentuk Map
  static Map<String, dynamic> getAllStorageMap() {
    final Map<String, dynamic> result = {};
    for (var key in _box.getKeys().cast<String>()) {
      result[key] = _box.read(key);
    }
    return result;
  }

  /// Set nilai ke storage
  static Future<void> setValue(String key, dynamic value) async {
    await _box.write(key, value);
    print('Set $key: $value');
  }

  /// Dapetin nilai dari storage
  static T? getValue<T>(String key, {T? defaultValue}) {
    try {
      return _box.read<T?>(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Hapus key dari storage
  static Future<void> removeKey(String key) async {
    await _box.remove(key);
    print('Removed key: $key');
  }

  /// Hapus semua data di storage
  static Future<void> clearAll() async {
    await _box.erase();
    print('Semua data storage telah dihapus');
  }
}
