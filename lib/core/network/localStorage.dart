import 'package:get_storage/get_storage.dart';

class StorageKeys {
  StorageKeys._();
  static const String authToken = 'auth_token';
}

class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  final GetStorage _box = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }

  ///Auth Token
  Future<void> saveToken(String token) async {
    await write(StorageKeys.authToken, token);
  }

  String? getToken() {
    return read<String>(StorageKeys.authToken);
  }

  Future<void> clearToken() async {
    await remove(StorageKeys.authToken);
  }

  bool get hasToken {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}