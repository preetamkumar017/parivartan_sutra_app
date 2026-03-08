import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_logger.dart';

class SharedPrefsService {
  SharedPrefsService._();
  static final SharedPrefsService instance = SharedPrefsService._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    AppLogger.info('SharedPrefs', 'Initialized');
  }

  // String
  Future<bool> setString(String key, String value) async {
    try {
      final result = await _prefs.setString(key, value);
      AppLogger.debug('SharedPrefs', 'setString key: $key');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'setString error for key $key: $e');
      return false;
    }
  }

  String? getString(String key, {String? defaultValue}) {
    try {
      return _prefs.getString(key) ?? defaultValue;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'getString error for key $key: $e');
      return defaultValue;
    }
  }

  // Bool
  Future<bool> setBool(String key, bool value) async {
    try {
      final result = await _prefs.setBool(key, value);
      AppLogger.debug('SharedPrefs', 'setBool key: $key = $value');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'setBool error for key $key: $e');
      return false;
    }
  }

  bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _prefs.getBool(key) ?? defaultValue;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'getBool error for key $key: $e');
      return defaultValue;
    }
  }

  // Int
  Future<bool> setInt(String key, int value) async {
    try {
      final result = await _prefs.setInt(key, value);
      AppLogger.debug('SharedPrefs', 'setInt key: $key = $value');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'setInt error for key $key: $e');
      return false;
    }
  }

  int getInt(String key, {int defaultValue = 0}) {
    try {
      return _prefs.getInt(key) ?? defaultValue;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'getInt error for key $key: $e');
      return defaultValue;
    }
  }

  // Double
  Future<bool> setDouble(String key, double value) async {
    try {
      final result = await _prefs.setDouble(key, value);
      AppLogger.debug('SharedPrefs', 'setDouble key: $key = $value');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'setDouble error for key $key: $e');
      return false;
    }
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    try {
      return _prefs.getDouble(key) ?? defaultValue;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'getDouble error for key $key: $e');
      return defaultValue;
    }
  }

  // StringList
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      final result = await _prefs.setStringList(key, value);
      AppLogger.debug('SharedPrefs', 'setStringList key: $key');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'setStringList error for key $key: $e');
      return false;
    }
  }

  List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    try {
      return _prefs.getStringList(key) ?? defaultValue;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'getStringList error for key $key: $e');
      return defaultValue;
    }
  }

  // Remove & Clear
  Future<bool> remove(String key) async {
    try {
      final result = await _prefs.remove(key);
      AppLogger.debug('SharedPrefs', 'Removed key: $key');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'Remove error for key $key: $e');
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      final result = await _prefs.clear();
      AppLogger.debug('SharedPrefs', 'All prefs cleared');
      return result;
    } catch (e) {
      AppLogger.error('SharedPrefs', 'Clear error: $e');
      return false;
    }
  }

  bool containsKey(String key) => _prefs.containsKey(key);

  Set<String> getKeys() => _prefs.getKeys();
}
