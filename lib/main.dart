import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:color_world/screens/category_screen.dart';
import 'package:color_world/billing_manager.dart';

void main() async {
  // Flutter framework'ünün hazır olduğundan emin oluyoruz
  WidgetsFlutterBinding.ensureInitialized();

  // Uygulamayı başlat
  runApp(const ColorWorldApp());

  // Servisleri arka planda başlat (UI'ı bekletmez)
  if (!kIsWeb) {
    _initServices();
  }
}

Future<void> _initServices() async {
  try {
    // 1. Reklamları başlat
    await MobileAds.instance.initialize();
    
    // 2. Billing (Satın alma) manager'ı başlat
    // Not: initialize() metodun void ise doğrudan çağır
    BillingManager().initialize();
    
  } catch (e) {
    debugPrint("Servis başlatma hatası: $e");
  }
}

class ColorWorldApp extends StatelessWidget {
  const ColorWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color World',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE94E77)),
      ),
      home: const CategoryScreen(),
    );
  }
}