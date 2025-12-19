import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoveAdsView extends StatefulWidget {
  const RemoveAdsView({super.key, required this.onWatchVideoButtonClicked, required this.onProductDetailsButtonClicked, required this.onLinkAccountButtonClicked, required this.onRestoreButtonClicked, required this.onSubscriptionDetailsClicked, required this.privacyPolicyLink});
  final VoidCallback onWatchVideoButtonClicked;
  final VoidCallback onLinkAccountButtonClicked;
  final VoidCallback onRestoreButtonClicked;
  final Function(StoreProduct) onProductDetailsButtonClicked;
  final VoidCallback onSubscriptionDetailsClicked;
  final String privacyPolicyLink;

  @override
  State<RemoveAdsView> createState() {
    return _RemoveAdsViewState();
  }
}

class _RemoveAdsViewState extends State<RemoveAdsView> {
  ColorScheme get _colorScheme => context.colorScheme;
  List<StoreProduct> _adsProducts = [];

  PurchaseHelper get purchaseHelper => coreGetIt<PurchaseHelper>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setup();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _setup() async {
    final adsProducts = await purchaseHelper.getProducts();
    setState(() {
      _adsProducts = adsProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            CoreS.current.removeAds,
            style: context.textTheme.titleLarge?.copyWith(color: _colorScheme.onSurface,),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16.r,),
        _buildRemoveAdsOneDayButton,
        ..._productDetailsItems,
        _buildTermOfUse,
        _buildCancelButton,
        SizedBox(height: 16.r,),
      ],
    );
  }

  Widget get _buildRemoveAdsOneDayButton {
    return SecondaryButton(
      onPressed: () {
        Navigator.pop(context);
        widget.onWatchVideoButtonClicked();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(CoreS.current.oneDay, style: context.textTheme.bodyLarge?.copyWith(color: _colorScheme.onPrimary, fontWeight: FontWeight.bold),),
                  Text(CoreS.current.watchVideo, style: context.textTheme.bodySmall?.copyWith(color: _colorScheme.onPrimary),),
                ],
              ),
            ),
            SizedBox(
              width: 40.r,
              height: 40.r,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Icon(CupertinoIcons.ticket_fill, size: 40.sp, color: _colorScheme.onPrimary),
                  Padding(
                    padding: const EdgeInsets.only(left: 6).r,
                    child: Icon(Icons.videocam_rounded, size: 20.sp, color: _colorScheme.surfaceTint),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _productDetailsItems {
    if(_adsProducts.isEmpty) {
      return [];
    }

    _adsProducts.sort((a, b) {
      return a.price.compareTo(b.price);
    });
    List<Widget> widgets = [
      SizedBox(height: 16.r,),
      Center(
        child: Text(
          CoreS.current.adsOr,
          style: context.textTheme.titleMedium?.copyWith(color: _colorScheme.onSurface, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 16.r,),];
    widgets.addAll(
        _adsProducts.map((e) {
          final id = e.identifier.split(":").first;
          if(id == purchaseHelper.oneYearId) {
            return _buildRemoveAdsOneYearButton(e);
          }
          if(id == purchaseHelper.lifeTimeId) {
            return _buildRemoveAdsForeverButton(e);
          }
          return Container();
        }).toList()
    );
    return widgets;
  }

  Widget _buildRemoveAdsOneYearButton(StoreProduct productDetails) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0).r,
      child: SecondaryButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onProductDetailsButtonClicked(productDetails);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(CoreS.current.oneYear, style: context.textTheme.bodyLarge?.copyWith(color: _colorScheme.onPrimary, fontWeight: FontWeight.bold),),
                    Text(CoreS.current.mostPopular, style: context.textTheme.bodySmall?.copyWith(color: _colorScheme.onPrimary),),
                  ],
                ),
              ),
              SizedBox(width: 4.r,),
              Text("${productDetails.priceString}/${CoreS.current.perYear}", style: context.textTheme.bodyLarge?.copyWith(color: _colorScheme.onPrimary, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveAdsForeverButton(StoreProduct productDetails) {
    return PrimaryButton(
      onPressed: () {
        Navigator.pop(context);
        widget.onProductDetailsButtonClicked(productDetails);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(CoreS.current.lifetime, style: context.textTheme.bodyLarge?.copyWith(color: _colorScheme.onPrimary, fontWeight: FontWeight.bold),),
                  Text(CoreS.current.bestValue, style: context.textTheme.bodySmall?.copyWith(color: _colorScheme.onPrimary),),
                ],
              ),
            ),
            Text(productDetails.priceString, style: context.textTheme.bodyLarge?.copyWith(color: _colorScheme.onPrimary, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  Widget get _buildCancelButton => Row(
    children: [
      Expanded(flex: 3, child: Container()),
      Expanded(
        flex: 4,
        child: SecondaryTextIconButton(
          height: 46.r,
          onPressed: () {
            Navigator.pop(context);
          }, text: CoreS.current.cancel, iconData: Icons.close_rounded,
        ),
      ),
      Expanded(flex: 3, child: Container()),
    ],
  );

  Widget get _buildRestoreButton {
    return _buildProfileDialogLink(context, "Restore purchases", iconData: Icons.restore_rounded, () async {
      Navigator.pop(context);
      widget.onRestoreButtonClicked();
    }, isDanger: true);
  }

  Widget get _buildTermOfUse {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16).r,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildRestoreButton,
              ),
              if(Platform.isIOS) Expanded(
                child: _buildProfileDialogLink(context, "Subscription details", () {
                  widget.onSubscriptionDetailsClicked();
                }, underline: true),
              ),
            ],
          ),
          if(Platform.isIOS) SizedBox(height: 8.r,),
          if(Platform.isIOS) Row(
            children: [
              Expanded(
                child: _buildProfileDialogLink(context, "Terms of service", () {
                  launchUrl(Uri.parse("https://www.apple.com/legal/internet-services/itunes/dev/stdeula"));
                }, underline: true),
              ),
              Expanded(
                child: _buildProfileDialogLink(context, "Privacy policy", () {
                  launchUrl(Uri.parse(widget.privacyPolicyLink));
                }, underline: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDialogLink(BuildContext context, String text, VoidCallback onPress, {IconData? iconData, bool isDanger = false, bool underline = false}) {
    final color = context.colorScheme.onSurfaceVariant;
    return Bounceable(
      onTap: onPress,
      child: SizedBox(
        height: 24.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
              size: 20.sp,
            ),
            SizedBox(width: 2.r,),
            AutoSizeText(text, maxLines: 1, style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              decoration: underline ? TextDecoration.underline : null,
            ),),
          ],
        ),
      ),
    );
  }
}
