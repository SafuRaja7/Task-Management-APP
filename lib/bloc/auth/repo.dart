import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/bloc/auth/cubit.dart';
import 'package:task_management/models/auth_data.dart';

class AuthRepository {
  Future<void> updateAuth(AuthData authData, int index) =>
      AuthDataProvider.updateAuth(authData, index);

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      AuthDataProvider.fetch();
}
