import 'dart:io';
import 'dart:ui';

import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdRewarded {
  AdRewarded({required this.coreSharedPreferencesHelper, required this.rewardedAdAndroidUnitId, required this.rewardedAdIOSUnitId});

  final CoreSharedPreferencesHelper coreSharedPreferencesHelper;
  final String rewardedAdAndroidUnitId;
  final String rewardedAdIOSUnitId;

  RewardedAd? _rewardedAd;
  int numOfAttemptLoad = 0;
  bool? ready;

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return rewardedAdAndroidUnitId;
    } else if (Platform.isIOS) {
      return rewardedAdIOSUnitId;
    } else {
      return "";
    }
  }

  Future<bool> adRemoved() async {
    var currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var removeAdTimeStamp = await coreSharedPreferencesHelper.removeAdStartTime();
    return currentTimeStamp - removeAdTimeStamp <= 86400 * 1000;
  }

  Future<void> showAd(VoidCallback onSuccess) async {
    if (ready == false) {
      return;
    }

    ready = false;
    if (_rewardedAd == null) {
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdDismissedFullScreenContent: (ad) => ad.dispose(),
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createAd();
      },
    );

    await _rewardedAd!.show(onUserEarnedReward: (ad, item) {
      coreSharedPreferencesHelper.setRemoveAdStartTime(DateTime.now().millisecondsSinceEpoch);
      onSuccess();
    });
    _rewardedAd = null;
  }

  void createAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          numOfAttemptLoad = 0;
          ready = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          numOfAttemptLoad++;
          _rewardedAd = null;
          if (numOfAttemptLoad <= 2) {
            createAd();
          }
        },
      ),
    );
  }
}
