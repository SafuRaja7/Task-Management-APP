import 'dart:math';

class AppUtils {
  static int generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final random = Random().nextInt(900000) + 100000;

    final uniqueId = timestamp * 1000000 + random;

    return uniqueId;
  }
}
