import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'app_dimensions.dart';
import 'app_theme.dart';
import 'app_typography.dart';
import 'space.dart';
import 'ui.dart';
import 'ui_props.dart';

class App {
  static bool? isLtr;
  static bool showAds = false;

  static init(BuildContext context) async {
    UI.init(context);
    AppDimensions.init();
    AppTheme.init(context);
    UIProps.init();
    Space.init();
    AppText.init();

    isLtr = Directionality.of(context) == TextDirection.ltr;
  }

  static String format(num number, [String? currencyPrefix]) {
    if (currencyPrefix != null && currencyPrefix.contains(" ")) {
      currencyPrefix = currencyPrefix.substring(0, currencyPrefix.length - 1);
    }
    return NumberFormat.currency(
      locale: 'ur',
      symbol: currencyPrefix ?? '\$',
      decimalDigits: 0,
    ).format(
      number,
    );
  }

  static String tourId([int? length]) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length ?? 8,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }

  static String id() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rand = Random();
    const dash = '-';
    final code = List.generate(
      9,
      (i) => i != 0 && i % 3 == 0 ? dash : chars[rand.nextInt(chars.length)],
    );
    return code.join();
  }
}
