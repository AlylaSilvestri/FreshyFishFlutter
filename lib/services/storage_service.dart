import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();

  void saveToken(String token) {
    storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return storage.read(key: 'token');
  }
}