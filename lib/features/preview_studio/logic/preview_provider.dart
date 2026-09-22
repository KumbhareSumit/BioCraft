import 'package:flutter/material.dart';

enum PreviewType { biodata, invitation }

class PreviewProvider with ChangeNotifier {
  PreviewType _previewType = PreviewType.biodata;
  double _zoomLevel = 1.0;
  bool _isExporting = false;

  PreviewType get previewType => _previewType;
  double get zoomLevel => _zoomLevel;
  bool get isExporting => _isExporting;

  void setPreviewType(PreviewType type) {
    _previewType = type;
    notifyListeners();
  }

  void setZoomLevel(double zoom) {
    _zoomLevel = zoom.clamp(0.5, 2.0);
    notifyListeners();
  }

  void zoomIn() {
    setZoomLevel(_zoomLevel + 0.1);
  }

  void zoomOut() {
    setZoomLevel(_zoomLevel - 0.1);
  }

  void resetZoom() {
    _zoomLevel = 1.0;
    notifyListeners();
  }

  void setIsExporting(bool value) {
    _isExporting = value;
    notifyListeners();
  }
}
