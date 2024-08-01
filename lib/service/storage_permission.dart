import 'package:permission_handler/permission_handler.dart';

class StoragePermission {
  static Future<bool> requestStorage() async {
    final isGranted = await Permission.storage.isGranted;
    if (!isGranted) {
      Permission.storage.request();
    }
    return isGranted;
  }
}
