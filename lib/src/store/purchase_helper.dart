import 'dart:async';
import 'dart:io';

import 'package:app_core/generated/l10n.dart';
import 'package:app_core/src/store/store_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseHelper {
  final String appleApiKey;
  final String googleApiKey;
  final String oneYearId;
  final String lifeTimeId;

  String entitlementID = 'premium';

  PurchaseHelper({required this.appleApiKey, required this.googleApiKey, required this.oneYearId, required this.lifeTimeId});

  void initConfig() {
    if (Platform.isIOS || Platform.isMacOS) {
      StoreConfig(
        store: Store.appStore,
        apiKey: appleApiKey,
      );
    } else if (Platform.isAndroid) {
      StoreConfig(
        store: Store.playStore,
        apiKey: googleApiKey,
      );
    }
  }

  Future<void> configureSDK() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser == null) {
      return;
    }

    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = firebaseUser.uid;
    await Purchases.configure(configuration);
  }

  Future<bool> isPremiumUser() async {
    if(!(await _canCheckPurchase)) {
      return false;
    }

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    EntitlementInfo? entitlementInfo = customerInfo.entitlements.all[entitlementID];
    if(entitlementInfo == null) {
      return false;
    }
    return entitlementInfo.isActive;
  }

  Future<bool> get _canCheckPurchase async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser == null) {
      return false;
    }

    return true;
  }

  Future<List<StoreProduct>> getProducts() async {
    List<StoreProduct> products = [];
    try {
      final subs = await Purchases.getProducts(
        [oneYearId],
        productCategory: ProductCategory.subscription,
      );
      final inApps = await Purchases.getProducts(
        [lifeTimeId],
        productCategory: ProductCategory.nonSubscription,
      );
      products.addAll(subs);
      products.addAll(inApps);
    } on PlatformException {
      return [];
    }
    return products;
  }

  Future buyProduct(StoreProduct storeProduct) async {
    try {
      await Purchases.purchaseStoreProduct(storeProduct);
    } on PlatformException {}
  }

  void listenCustomerInfoUpdate(CustomerInfoUpdateListener listener) {
    Purchases.addCustomerInfoUpdateListener(listener);
  }

  Future<String> restorePurchase() async {
    const errorMessage = "Your Account ID does not match. Please log in with the correct account to do this!";
    try {
      await Purchases.restorePurchases();
    } on PlatformException catch (_) {
      return errorMessage;
    }

    final isPremium = await isPremiumUser();
    if(!isPremium) {
      return errorMessage;
    }
    return "Success!";
  }

  Future<String> getPremiumType() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    EntitlementInfo? entitlementInfo = customerInfo.entitlements.all[entitlementID];
    if(entitlementInfo == null) {
      return "";
    }
    if(!entitlementInfo.isActive) {
      return "";
    }
    String? expirationDate = entitlementInfo.expirationDate;
    if(expirationDate == null) {
      return CoreS.current.lifetime;
    }
    try {
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(expirationDate, true);
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      return dateFormat.format(parseDate.toLocal());
    } catch (_) {
      try {
        DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(expirationDate, true);
        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(parseDate.toLocal());
      } catch (_) {
        return expirationDate;
      }
    }
  }
}