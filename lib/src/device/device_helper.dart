import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceHelper {
  static Future<bool> isOffline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isOffline = checkOfflineForResult(connectivityResult);
    // On iOS, I don't known why first time is none, so, I try to check one more time...
    if(isOffline) {
      final connectivityResultAgain = await Connectivity().checkConnectivity();
      return checkOfflineForResult(connectivityResultAgain);
    }
    return isOffline;
  }

  static bool checkOfflineForResult(List<ConnectivityResult> connectivityResult) {
    final isOnline = connectivityResult.contains(ConnectivityResult.mobile)
        || connectivityResult.contains(ConnectivityResult.wifi)
        || connectivityResult.contains(ConnectivityResult.vpn)
        || connectivityResult.contains(ConnectivityResult.ethernet)
        || connectivityResult.contains(ConnectivityResult.other);
    return !isOnline;
  }

  static bool isTablet(BuildContext context) => ScreenUtil().deviceType(context) == DeviceType.tablet;
  static double safeAreaPaddingBottom(BuildContext context) => MediaQuery.of(context).padding.bottom / (Platform.isIOS ? 2 : 1);
}