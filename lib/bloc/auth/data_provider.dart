part of 'cubit.dart';

class AuthDataProvider {
  static final firebaseFirestore = FirebaseFirestore.instance;
  static final userCollection = firebaseFirestore.collection('users_prod');

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() {
    try {
      return userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .asBroadcastStream();
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<AuthData> login(String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      final data = await userCollection.doc(user.uid).get();
      final authData = AuthData.fromMap(data.data()!);

      return authData;
    } on FirebaseAuthException catch (e) {
      final err = e.toString();
      throw Exception(err);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<AuthData> signUp(
    String fullName,
    String email,
    String password,
    String type,
    String deviceToken,
  ) async {
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      final authData = AuthData.fromMap({
        'id': user.uid,
        'fullName': fullName,
        'email': email,
        'type': type,
        'deviceToken': deviceToken,
      });

      await user.updateDisplayName(fullName);

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      await userCollection.doc(user.uid).set(authData.toMap());

      if (kDebugMode) {
        firebaseFirestore
            .collection('users_prod')
            .doc(user.uid)
            .set(authData.toMap());
      }

      return authData;
    } on FirebaseAuthException catch (e) {
      final err = e.toString();
      throw Exception(err);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<void> updateAuth(AuthData authData, int index) async {
    try {
      final raw = await userCollection.doc(authData.id).get();
      List data = raw.data()!['users_prod'];

      data.removeAt(index);

      data.insert(
        index,
        authData.toMap(),
      );

      await userCollection.doc(authData.id).set(
        {'users_prod': data},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
