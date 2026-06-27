import 'package:shared_preferences/shared_preferences.dart';

class BillingManager {
  static const String _adFreeKey = 'is_ad_free';

  // Reklamsız versiyon satın alınmış mı kontrol eder
  static Future<bool> isAdFree() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_adFreeKey) ?? false;
  }

  // Satın alma başarılı olduğunda çağrılacak fonksiyon
  static Future<void> setAdFree(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_adFreeKey, value);
  }
}