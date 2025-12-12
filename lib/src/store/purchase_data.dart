class PurchaseData {
  static final PurchaseData _appData = PurchaseData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';

  factory PurchaseData() {
    return _appData;
  }
  PurchaseData._internal();
}
