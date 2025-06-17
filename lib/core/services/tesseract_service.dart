library tesseract;

import 'dart:js_util';
import 'package:js/js.dart';

@JS('Tesseract.recognize')
external dynamic _recognize(dynamic image, String lang, [dynamic options]);

Future<String> recognizeText(dynamic image) async {
  final result = await promiseToFuture(_recognize(image, 'eng'));
  return getProperty(result, 'data').text;
}
