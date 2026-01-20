import 'package:app_core/app_core.dart';
import 'package:app_core/src/device/device_helper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum MessageType {
  notice,
  success,
  error,
}

class BottomSheetHelper {
  static void showLoading(BuildContext context) async {
    showCoreBottomSheet(
      context,
      isDismissible: false,
      widgetBuilder: (context) => SizedBox(
        height: 50.r,
        child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: context.colorScheme.onSurface,
            size: 48.r,
          ),
        ),
      ),
    );
  }

  static Widget _buildBottomDialogContainer(BuildContext context, {required Widget child, Color? backgroundColor}) {
    return CupertinoCard(
      elevation: 0,
      padding: EdgeInsets.only(
        left: 16.r,
        right: 16.r,
        top: 16.r,
        bottom: 16.r + DeviceHelper.safeAreaPaddingBottom(context),
      ),
      margin: EdgeInsets.zero,
      color: backgroundColor ?? context.colorScheme.surfaceContainer,
      radius: BorderRadius.only(
        topLeft: Radius.circular(32).r,
        topRight: Radius.circular(32).r,
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: child,
    );
  }

  static Future<dynamic> showCoreBottomSheet(BuildContext context, {required WidgetBuilder widgetBuilder, bool isDismissible = true}) async {
    return showMaterialModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(180),
      builder: (dlContext) {
        return _buildBottomDialogContainer(
          context,
          child: widgetBuilder(dlContext),
        );
      },
    );
  }

  static Future<dynamic> showConfirmBottomSheet(BuildContext context, String message, {String? description, IconData? iconData, Color? color, required VoidCallback onAgree, String cancelText = "Cancel", String okText = "OK"}) async {
    return showCoreBottomSheet(
        context,
        widgetBuilder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 56.r,
                    width: 56.r,
                    child: Icon(iconData, size: 36.r, color: context.colorScheme.onSurface,),
                  ),
                  SizedBox(width: 8.r,),
                  Expanded(
                    child: AutoSizeText(
                      message,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              if(description != null) Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextIconButton(
                        color: Colors.grey.shade600,
                        shadowColor: Colors.grey.shade800,
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        height: 36.r,
                        iconData: Icons.close_rounded,
                        text: cancelText,
                      ),
                    ),
                    SizedBox(width: 8.r,),
                    Expanded(
                      child: PrimaryTextIconButton(
                        color: Colors.green.shade300,
                        shadowColor: Colors.green.shade500,
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          await Future.delayed(Duration(milliseconds: 200),);
                          onAgree.call();
                        },
                        height: 36.r,
                        iconData: Icons.check_rounded,
                        text: okText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  static void showMessageDialog(BuildContext context, {required String message, String? description, MessageType type = MessageType.notice, IconData? iconData,}) async {
    Color contentColor;
    IconData defaultIconData;
    switch(type) {
      case MessageType.notice:
        contentColor = context.colorScheme.onSurface;
        defaultIconData = Icons.info_outline_rounded;
        break;
      case MessageType.success:
        contentColor = Colors.green.shade400;
        defaultIconData = Icons.check_circle_rounded;
        break;
      case MessageType.error:
        contentColor = Colors.red.shade400;
        defaultIconData = CupertinoIcons.clear_circled_solid;
        break;
    }

    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87,
      context: context,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        return _buildBottomDialogContainer(
          context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    iconData ?? defaultIconData,
                    color: contentColor,
                    size: 32.r,
                  ),
                  SizedBox(width: 8.r,),
                  Expanded(
                    child: Text(
                      message,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: contentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.r,),
              if(description != null) Text(
                description,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}