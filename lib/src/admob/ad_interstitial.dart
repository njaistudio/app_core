import 'dart:io';

import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:app_core/src/store/purchase_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInterstitial {
  AdInterstitial({required this.coreSharedPreferencesHelper, required this.purchaseHelper, required this.interstitialAdAndroidUnitId, required this.interstitialAdIOSUnitId});

  final CoreSharedPreferencesHelper coreSharedPreferencesHelper;
  final PurchaseHelper purchaseHelper;
  final String interstitialAdAndroidUnitId;
  final String interstitialAdIOSUnitId;

  InterstitialAd? _interstitialAd;
  int numOfAttemptLoad = 0;
  bool? ready;
  int screenPercent = 1;

  Future<int> getCurrentCount() {
    return coreSharedPreferencesHelper.currentAdsCount();
  }

  Future<bool> canShowAds() async {
    final isPremium = await purchaseHelper.isPremiumUser();
    if(isPremium) {
      return false;
    }
    var currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var removeAdTimeStamp = await coreSharedPreferencesHelper.removeAdStartTime();
    if(currentTimeStamp - removeAdTimeStamp <= 86400 * 1000) {
      coreSharedPreferencesHelper.resetIncreaseAdsCount();
      return false;
    }

    var currentAdsCount = await getCurrentCount();
    var limit = await coreSharedPreferencesHelper.getShowAdsLimit();
    return currentAdsCount >= limit;
  }

  Future<bool> justShowAds() async {
    var currentAdsCount = await getCurrentCount();
    return currentAdsCount == 0;
  }

  Future<void> increaseAdsCountWithNumber(number) async {
    coreSharedPreferencesHelper.increaseAdsCountWithNumber(number);
    var canShow = await canShowAds();
    if (canShow) {
      _createAd();
      await coreSharedPreferencesHelper.resetIncreaseAdsCount();
    }
  }

  void _createAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          numOfAttemptLoad = 0;
          ready = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          numOfAttemptLoad++;
          _interstitialAd = null;
          if (numOfAttemptLoad <= 2) {
            _createAd();
          }
        },
      ),
    );
  }

  Future<void> showAd() async {
    if (ready == false) {
      return;
    }

    ready = false;
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        ad.dispose();
        _createAd();
      },
    );
    await _interstitialAd!.show();
    _interstitialAd = null;
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return interstitialAdAndroidUnitId;
    } else if (Platform.isIOS) {
      return interstitialAdIOSUnitId;
    } else {
      return "";
    }
  }
}
