import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/models/notifications.dart';


part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  static NotificationsCubit cubit(BuildContext context,
          [bool listen = false]) =>
      BlocProvider.of<NotificationsCubit>(context, listen: listen);

  NotificationsCubit() : super(NotificationsDefault());

  final repo = NotificationsRepository();

  Future<void> sendPushNotification(
      String adminToken, NotificationBody body) async {
    emit(const NotificationsSendLoading());
    try {
      final data = await repo.sendPushMessage(adminToken, body);

      emit(NotificationsSendSuccess(data: data));
    } catch (e) {
      emit(NotificationsSendFailed(message: e.toString()));
    }
  }
}
