import 'dart:convert';

import 'package:app_core/src/data/storage/storage_target.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreSharedPreferencesHelper {
  static const currentLanguageKey = "currentLanguageKey";
  static const mutedKey = "mutedKey";
  static const adsCount = "adsCount";
  static const versionKey = "versionKey";
  static const targetKey = "targetKey";
  static const removeAdStartTimeKey = "removeAdStartTimeKey";
  static const showAdsLimitKey = "showAdsLimitKey";

  Future<int> getShowAdsLimit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(showAdsLimitKey) ?? 30;
  }

  Future saveShowAdsLimit(int number) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(showAdsLimitKey, number);
  }

  Future<String> currentLanguage({bool removeFromAs = true}) async {
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString(currentLanguageKey) ?? "";
    if(removeFromAs) {
      language = language.split('_from_').first;
    }
    return language;
  }

  Future setCurrentLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(currentLanguageKey, value);
  }

  Future<bool> muted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(mutedKey) ?? false;
  }

  Future setMuted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(mutedKey, value);
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
  Future setCurrentVersion(int version) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(versionKey, version);
  }

  Future<int> currentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(versionKey) ?? 0;
  }

  Future<int> removeAdStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(removeAdStartTimeKey) ?? 0;
  }

  Future setRemoveAdStartTime(int timeStamp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(removeAdStartTimeKey, timeStamp);
  }

  Future<StorageTarget> getTarget() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString(targetKey) ?? "";
    if(string.isEmpty) {
      return StorageTarget();
    }
    return StorageTarget.fromJson(jsonDecode(string));
  }

  Future setTarget(StorageTarget target) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(targetKey, jsonEncode(target.toJson()));
  }

  Future clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(currentLanguageKey);
    prefs.remove(adsCount);
    prefs.remove(mutedKey);
    prefs.remove(versionKey);
    prefs.remove(targetKey);
  }
}
