import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  String kissjInstance = '';
  String eventSecret = '';

  // Singleton instance
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  Future<void> initialize() async {
    // Load configuration data from SharedPreferences or another source
    // Initialize kissjInstance, apiKey, and event here
    final prefs = await SharedPreferences.getInstance();
    kissjInstance = prefs.getString('kissjInstance') ?? 'staging.kissj.net';
    eventSecret = prefs.getString('eventSecret') ?? '';
    await saveConfig();
  }

  Future<void> saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('kissjInstance', kissjInstance);
    await prefs.setString('eventSecret', eventSecret);
  }
}
