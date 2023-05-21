import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppUtil {
  static AppUtil? _instance;
  // Avoid self instance
  AppUtil._();
  static AppUtil get instance {
    _instance ??= AppUtil._();
    return _instance!;
  }

  static FilteringTextInputFormatter get numberOnly =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static FilteringTextInputFormatter get allowDecimal =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]+[,.]{0,1}[0-9]*'),
      );

  static NumberFormat get format2Disgit => NumberFormat('#,##0.00');
  static NumberFormat get formatNoneDecimal => NumberFormat('#,##0');
}
