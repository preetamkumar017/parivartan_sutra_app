import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/app_logger.dart';

class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();

  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: _androidOptions,
    iOptions: _iosOptions,
  );

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      AppLogger.debug('SecureStorage', 'Written key: $key');
    } catch (e) {
      AppLogger.error('SecureStorage', 'Write error for key $key: $e');
    }
  }

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      AppLogger.debug('SecureStorage', 'Read key: $key, hasValue: ${value != null}');
      return value;
    } catch (e) {
      AppLogger.error('SecureStorage', 'Read error for key $key: $e');
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      AppLogger.debug('SecureStorage', 'Deleted key: $key');
    } catch (e) {
      AppLogger.error('SecureStorage', 'Delete error for key $key: $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      AppLogger.debug('SecureStorage', 'All keys deleted');
    } catch (e) {
      AppLogger.error('SecureStorage', 'DeleteAll error: $e');
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      AppLogger.error('SecureStorage', 'ContainsKey error for key $key: $e');
      return false;
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      AppLogger.error('SecureStorage', 'ReadAll error: $e');
      return {};
    }
  }
}
