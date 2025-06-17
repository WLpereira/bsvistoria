import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bs_vistoria_veicular/core/services/tesseract_service.dart';

class OcrScanService {
  final ImagePicker _picker = ImagePicker();
  TextRecognizer? _textRecognizer;

  OcrScanService() {
    if (!kIsWeb) {
      _textRecognizer = TextRecognizer();
    }
  }

  Future<String?> scanImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      if (kIsWeb) {
        // Use Tesseract.js for web
        final imagePath = pickedFile.path;
        return await recognizeText(imagePath);
      } else {
        // Use Google ML Kit for mobile
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        final RecognizedText recognizedText =
            await _textRecognizer!.processImage(inputImage);
        return recognizedText.text;
      }
    } else {
      return null;
    }
  }

  void dispose() {
    if (_textRecognizer != null) {
      _textRecognizer!.close();
    }
  }
}
