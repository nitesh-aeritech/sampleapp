import 'package:flutter/services.dart';

class DoubleFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final value = newValue.text;
    if (value.contains(',') || value.contains('-') || value.contains('+') || value.contains(' ')) {
      final value11 = oldValue.text.replaceAll('-', '').replaceAll('+', '').replaceAll(',', '').replaceAll(' ', '');
      final vv = oldValue.copyWith(text: value11);
      return TextEditingValue(
        composing: vv.composing,
        text: value11,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: value11.length - 1,
            affinity: TextAffinity.upstream,
          ),
        ),
      );
    }
    if (value.length > 10) return oldValue;
    final parser = double.tryParse(value);
    if (parser == null) return oldValue;
    if (newValue.text.contains('.')) {
      final value = newValue.text.split('.').last;
      if (value.length > 4) {
        return oldValue;
      }
    }

    return newValue;
  }
}
