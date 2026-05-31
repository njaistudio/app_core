import 'dart:convert';

import 'package:app_core/src/data/storage/storage_target.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreSharedPreferencesHelper {
  static const adsCount = "adsCount_v1";
  static const targetKey = "targetKey";
  static const removeAdStartTimeKey = "removeAdStartTimeKey_v1";
  static const showAdsLimitKey = "showAdsLimitKey_v1";
  static const reviewCountKey = "reviewCountKey";

  Future<int> getShowAdsLimit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(showAdsLimitKey) ?? 30;
  }

  Future saveShowAdsLimit(int number) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(showAdsLimitKey, number);
  }

  Future<int> currentAdsCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(adsCount) ?? 0;
  }

  Future resetIncreaseAdsCount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(adsCount, 0);
  }

  Future increaseAdsCountWithNumber(int number) async {
    final prefs = await SharedPreferences.getInstance();
    var current = prefs.getInt(adsCount) ?? 0;
    prefs.setInt(adsCount, current + number);
  }

  Future<int> removeAdStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(removeAdStartTimeKey) ?? 0;
  }

  Future setRemoveAdStartTime(int timeStamp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(removeAdStartTimeKey, timeStamp);
  }

  Future<StorageTarget> getTarget({String version = ""}) async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString(targetKey + version) ?? "";
    if(string.isEmpty) {
      return StorageTarget();
    }
    return StorageTarget.fromJson(jsonDecode(string));
  }

  Future setTarget(StorageTarget target) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(targetKey, jsonEncode(target.toJson()));
  }

  Future<int> reviewCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(reviewCountKey) ?? 0;
  }

  Future setReviewCount(int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(reviewCountKey, value);
  }

  Future removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(adsCount);
    prefs.remove(targetKey);
    prefs.remove(reviewCountKey);
  }
}
