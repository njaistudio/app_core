import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

abstract class BaseUiEvent {}

enum MessageType {
  notice,
  success,
  error,
}

class ShowLoadingEvent extends BaseUiEvent {}
class HideLoadingEvent extends BaseUiEvent {}
class PopBackEvent extends BaseUiEvent {
  dynamic result;
  PopBackEvent({this.result});
}

class ShowMessageEvent extends BaseUiEvent {
  final String message;
  final String? description;
  final MessageType type;
  final IconData? iconData;
  ShowMessageEvent({required this.message, this.type = MessageType.notice, this.iconData, this.description});
}

class ShowConfirmEvent extends BaseUiEvent {
  final String message;
  final String? description;
  final IconData? iconData;
  final VoidCallback onAgree;
  ShowConfirmEvent({required this.message, this.iconData, this.description, required this.onAgree});
}

class CoreBaseViewModel extends ChangeNotifier {
  final _eventController = StreamController<BaseUiEvent>.broadcast();
  Stream<BaseUiEvent> get eventStream => _eventController.stream;

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }

  void sendEvent(BaseUiEvent event) {
    _eventController.add(event);
  }

  Future<void> runTask<T>(
      Future<Either<Failure, T>> Function() function, {
        required Function(T data) onSuccess,
        Function(Failure failure)? onError,
        bool useLoading = true,
        bool needCheckNetWork = false,
      }) async {
    if(needCheckNetWork) {
      final isOffline = await DeviceHelper.isOffline();
      if(isOffline) {
        sendEvent(ShowMessageEvent(
          message: "No internet connection",
          description: "Please check your internet connection",
          type: MessageType.error,
          iconData: Icons.signal_wifi_connected_no_internet_4_rounded,
        ));
        onError?.call(NetWorkError());
        return;
      }
    }
    if (useLoading) {
      sendEvent(ShowLoadingEvent());
    }

    final minTime = Future.delayed(const Duration(milliseconds: 500));

    final result = await function();

    if (useLoading) {
      await minTime;
      sendEvent(HideLoadingEvent());
    }

    result.fold((failure) {
      if (onError != null) {
        onError(failure);
      } else {
        sendEvent(ShowMessageEvent(
          message: failure.message,
          type: MessageType.error,
        ));
      }
    }, (data) {
      onSuccess(data);
    },);
  }
}