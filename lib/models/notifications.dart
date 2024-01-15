// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationBody {
  final String body;
  final String title;
  final DateTime createdAt;


  final String? message;
  final String? propertyName;
  NotificationBody({
    required this.body,
    required this.title,
    required this.createdAt,
    this.message,
    this.propertyName,
  });

  NotificationBody copyWith({
    String? body,
    String? title,
    DateTime? createdAt,
    String? message,
    String? propertyName,
  }) {
    return NotificationBody(
      body: body ?? this.body,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      propertyName: propertyName ?? this.propertyName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'message': message,
      'propertyName': propertyName,
    };
  }

  factory NotificationBody.fromMap(Map<String, dynamic> map) {
    return NotificationBody(
      body: map['body'] as String,
      title: map['title'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      message: map['message'] != null ? map['message'] as String : null,
      propertyName: map['propertyName'] != null ? map['propertyName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationBody.fromJson(String source) =>
      NotificationBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationBody(body: $body, title: $title, createdAt: $createdAt, message: $message, propertyName: $propertyName)';
  }

  @override
  bool operator ==(covariant NotificationBody other) {
    if (identical(this, other)) return true;
  
    return 
      other.body == body &&
      other.title == title &&
      other.createdAt == createdAt &&
      other.message == message &&
      other.propertyName == propertyName;
  }

  @override
  int get hashCode {
    return body.hashCode ^
      title.hashCode ^
      createdAt.hashCode ^
      message.hashCode ^
      propertyName.hashCode;
  }
}
