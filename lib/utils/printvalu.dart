import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

void printvalue(dynamic value, {String tag = ""}) {
  try {
    var decodedJson = json.decode(value.toString()) as Map<String, dynamic>;
    log('Json Output : $tag ${const JsonEncoder.withIndent('').convert(decodedJson)}\n');
  } catch (_) {
    if (value is Map) {
      log('Json Output : $tag ${const JsonEncoder.withIndent('').convert(value)}\n');
    } else {
      if (kDebugMode) {
        print('print output : $tag $value\n\n');
      }
    }
  }
}
