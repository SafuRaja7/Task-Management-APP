import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/bloc/tasks/data_provider.dart';
import 'package:task_management/models/task_model.dart';

class TaskRepo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      TaskDataProvider.fetch();

  Future<void> add(TaskModel taskModel) => TaskDataProvider.add(taskModel);

  Future<void> update(TaskModel taskModel, int index) =>
      TaskDataProvider.update(taskModel, index);
  Future<void> delete(int taskId) => TaskDataProvider.delete(taskId);
}
