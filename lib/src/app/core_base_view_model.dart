import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseUiEvent {}

enum MessageType {
  notice,
  success,
  error,
}

class ShowLoadingEvent extends BaseUiEvent {}
class HideLoadingEvent extends BaseUiEvent {}

class ShowMessageEvent extends BaseUiEvent {
  final String message;
  final String? description;
  final MessageType type;
  final IconData? iconData;
  ShowMessageEvent({required this.message, this.type = MessageType.notice, this.iconData, this.description});
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

  void requiredNetworkRun(Function() run) async {
    final isOffline = await DeviceHelper.isOffline();
    if(isOffline) {
      sendEvent(ShowMessageEvent(
        message: "No internet connection",
        description: "Please check your internet connection",
        type: MessageType.error,
        iconData: Icons.signal_wifi_connected_no_internet_4_rounded,
      ));
      return;
    }
    run.call();
  }

  Future<void> runTask<T>(
      Future<Either<Failure, T>> Function() function, {
        required Function(T data) onSuccess,
        Function(Failure failure)? onError,
        bool useLoading = true,
      }) async {
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