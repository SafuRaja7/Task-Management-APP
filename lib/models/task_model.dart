// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  String title;
  String description;
  final DateTime createdat;
  String status;
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdat,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      createdat,
      status,
    ];
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdat,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdat: createdat ?? this.createdat,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdat': createdat.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      createdat: DateTime.fromMillisecondsSinceEpoch(map['createdat'] as int),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
