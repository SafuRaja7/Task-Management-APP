import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/task_model.dart';

class TaskDataProvider {
  static final tasks = FirebaseFirestore.instance.collection('tasks');

  static DocumentReference<Map<String, dynamic>> getOrdersDocument() {
    return tasks.doc('data');
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() {
    try {
      return getOrdersDocument().snapshots().asBroadcastStream();
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<void> add(TaskModel ordersModel) async {
    try {
      final DocumentReference<Map<String, dynamic>> tasks =
          getOrdersDocument();
      final raw = await tasks.get();

      final data = raw.data() ?? {'tasks': []};

      List expe = data['tasks'] ?? [];
      expe.add(ordersModel.toMap());

      await tasks.set({'tasks': expe});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(TaskModel taskModel, int index) async {
    try {
      final DocumentReference<Map<String, dynamic>> tasks =
          getOrdersDocument();
      final raw = await tasks.get();
      List data = raw.data()!['tasks'];

      data.sort((a, b) => b['currentDate'].compareTo(a['currentDate']));

      data.removeAt(index);

      data.insert(
        index,
        taskModel.toMap(),
      );

      await tasks.set(
        {'tasks': data},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
