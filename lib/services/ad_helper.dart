import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static InterstitialAd? _interstitialAd;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          _interstitialAd = null;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null; 
      loadInterstitialAd(); // Bir sonraki sayfa için yenisini hemen yükle
    }
  }
}