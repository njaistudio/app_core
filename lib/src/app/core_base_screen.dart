import 'dart:async';
import 'package:app_core/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class CoreBaseScreen<T extends CoreBaseViewModel> extends StatefulWidget {
  const CoreBaseScreen({super.key});

  @override
  CoreBaseScreenState<CoreBaseScreen<T>, T> createState();
}

class CoreBaseScreenState<W extends CoreBaseScreen<T>, T extends CoreBaseViewModel> extends State<W> {
  late BuildContext providerContext;
  StreamSubscription? _eventSubscription;
  bool _isLoadingDialogShowing = false;

  T get readBaseViewModel => providerContext.read<T>();
  T get watchBaseViewModel => providerContext.watch<T>();

  ColorScheme get colorScheme => context.colorScheme;
  List<SingleChildWidget> get supportingProviders => [];

  bool get needSafeArea => false;

  AppBar get appBar => AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    toolbarHeight: 0,
  );

  Widget get body => Container();

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  void _setupEvent() {
    if(_eventSubscription != null) return;
    _eventSubscription = readBaseViewModel.eventStream.listen((event) {
      _handleGlobalEvent(event);
    });
  }

  void onEvent(BaseUiEvent event) {}

  void _handleGlobalEvent(BaseUiEvent event) {
    if (event is ShowLoadingEvent) {
      _showLoading();
    } else if (event is HideLoadingEvent) {
      _hideLoading();
    } else if (event is ShowMessageEvent) {
      _showMessageDialog(
        message: event.message,
        type: event.type,
        iconData: event.iconData,
        description: event.description,
      );
    } else {
      onEvent(event);
    }
  }

  void _showLoading() {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return _buildBottomDialogContainer(
            child: SizedBox(
              height: 50.r,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: colorScheme.onSurface,
                  size: 48.r,
                ),
              ),
            ),
          );
        },
      ).then((_) {
        _isLoadingDialogShowing = false;
      });
    }
  }

  _buildBottomDialogContainer({required Widget child, Color? backgroundColor}) {
    return CupertinoCard(
      elevation: 0,
      padding: EdgeInsets.only(
        left: 16.r,
        right: 16.r,
        top: 16.r,
        bottom: DeviceHelper.safeAreaPaddingBottom(context),
      ),
      margin: EdgeInsets.zero,
      color: backgroundColor ?? colorScheme.surfaceContainer,
      radius: BorderRadius.only(
        topLeft: Radius.circular(32).r,
        topRight: Radius.circular(32).r,
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: child,
    );
  }

  void _hideLoading() {
    if (_isLoadingDialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showMessageDialog({
    required String message,
    String? description,
    MessageType type = MessageType.notice,
    IconData? iconData,
  }) async {
    if(_isLoadingDialogShowing) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    if(!mounted) return;

    Color contentColor;
    IconData defaultIconData;
    switch(type) {
      case MessageType.notice:
        contentColor = colorScheme.onSurface;
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

    showBarModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      context: context,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        return _buildBottomDialogContainer(
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.instance.get<T>()),
        ...supportingProviders
      ],
      child: Consumer(
        builder: (providerContext, viewModel, child) {
          this.providerContext = providerContext;
          _setupEvent();
          return _scaffold;
        },
      ),
    );
  }

  Widget get _scaffold {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: needSafeArea ? Container(
        color: colorScheme.surface,
        child: SafeArea(
          child: SizedBox.expand(
            child: body,
          ),
        ),
      ) : Container(
        color: colorScheme.surface,
        child: SizedBox.expand(
          child: body,
        ),
      ),
    );
  }
}