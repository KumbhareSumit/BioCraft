import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
    String? subject,
    String? text,
  }) async {
    try {
      if (kIsWeb) {
        await Printing.sharePdf(bytes: bytes, filename: fileName);
        return;
      }
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path, mimeType: mimeType)],
        subject: subject,
        text: text,
      );
    } catch (e) {
      debugPrint('Error sharing file: $e');
    }
  }

  static Future<void> sharePdf(
    Uint8List pdfBytes, {
    String filename = 'Biodata.pdf',
    String? subject,
    String? text,
  }) async {
    await shareBytes(
      bytes: pdfBytes,
      fileName: filename,
      mimeType: 'application/pdf',
      subject: subject,
      text: text,
    );
  }

  static Future<void> shareImage(
    Uint8List imageBytes, {
    String filename = 'Biodata.png',
    String? subject,
    String? text,
  }) async {
    await shareBytes(
      bytes: imageBytes,
      fileName: filename,
      mimeType: 'image/png',
      subject: subject,
      text: text,
    );
  }

  static Future<void> printDocument(Uint8List pdfBytes, {String name = 'BioCraft Document'}) async {
    await Printing.layoutPdf(
      onLayout: (format) async => pdfBytes,
      name: name,
    );
  }
}
