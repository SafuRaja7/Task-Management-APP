part of 'cubit.dart';

class NotificationsDataProvider {
  static final firebase = FirebaseFirestore.instance;
  static final notificationRef = firebase.collection('notifications');
  static String serverKey =
      'AAAA8kd3DJc:APA91bEb3ts0j2oBOqaClpcNNxq8ffetdDwhIlHZbbvjMzT0VYjAMm2GDdPoT_JmYolAkjQKcU8QJ7FBaOwI8nEd4rOG1O-XM0cIjDFjIXVbTIohYJSw0jWFh39OsqHRvT49PeypgPWY';

  static Future<void> sendPushMessage(
      String token, NotificationBody notificationBody) async {
    try {
      final headers = <String, String>{
        'content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };

      final body = {
        'registration_ids': [token],
        'priority': 'high',
        'data': {
          'via': 'Flutter Cloud Messaging',
        },
        'notification': {
          'title': notificationBody.title,
          'body': notificationBody.body,
        }
      };

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: jsonEncode(body),
      );

      storeNotificationBody(notificationBody);
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<void> storeNotificationBody(
      NotificationBody notificationBody) async {
    try {
      notificationRef.add(notificationBody.toMap());
    } catch (e) {
      throw e.toString();
    }
  }
}
