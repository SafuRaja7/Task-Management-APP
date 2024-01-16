part of 'cubit.dart';

class NotificationsRepository {
  Future sendPushMessage(String adminToken, NotificationBody body) =>
      NotificationsDataProvider.sendPushMessage(adminToken, body);
}
