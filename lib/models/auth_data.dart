// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthData {
  final String id;
  final String? fullName;
  final String email;
  final String type;
  final String deviceToken;

  AuthData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.type,
    required this.deviceToken,
  });

  AuthData copyWith({
    String? id,
    String? fullName,
    String? email,
    String? type,
    String? deviceToken,
  }) {
    return AuthData(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      type: type ?? this.type,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'type': type,
      'deviceToken': deviceToken,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      id: map['id'] as String,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] as String,
      type: map['type'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(id: $id, fullName: $fullName, email: $email, type: $type, deviceToken: $deviceToken)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.fullName == fullName &&
      other.email == email &&
      other.type == type &&
      other.deviceToken == deviceToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      type.hashCode ^
      deviceToken.hashCode;
  }
}
