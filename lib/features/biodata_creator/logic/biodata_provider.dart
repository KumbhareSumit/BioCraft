import 'package:flutter/foundation.dart';
import '../../../core/services/storage_service.dart';
import '../data/models/biodata_model.dart';

class BiodataProvider with ChangeNotifier {
  BiodataModel _currentBiodata = BiodataModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
  );

  List<BiodataModel> _savedBiodatas = [];
  bool _isLoading = false;
  int _currentStep = 0;

  BiodataModel get currentBiodata => _currentBiodata;
  List<BiodataModel> get savedBiodatas => _savedBiodatas;
  bool get isLoading => _isLoading;
  int get currentStep => _currentStep;

  BiodataProvider() {
    loadSavedBiodatas();
  }

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void updateBiodata(BiodataModel updated) {
    _currentBiodata = updated;
    notifyListeners();
  }

  void updateField(BiodataModel Function(BiodataModel current) updateFn) {
    _currentBiodata = updateFn(_currentBiodata);
    notifyListeners();
  }

  void createNewBiodata() {
    _currentBiodata = BiodataModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _currentStep = 0;
    notifyListeners();
  }

  void loadBiodata(BiodataModel biodata) {
    _currentBiodata = biodata;
    _currentStep = 0;
    notifyListeners();
  }

  void loadSampleBiodata() {
    _currentBiodata = BiodataModel.sample();
    _currentStep = 0;
    notifyListeners();
  }

  Future<void> loadSavedBiodatas() async {
    _isLoading = true;
    notifyListeners();
    try {
      final storage = await StorageService.getInstance();
      _savedBiodatas = await storage.getSavedBiodatas();
    } catch (e) {
      debugPrint('Error loading saved biodatas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCurrentBiodata() async {
    try {
      final storage = await StorageService.getInstance();
      await storage.saveBiodata(_currentBiodata);
      await loadSavedBiodatas();
    } catch (e) {
      debugPrint('Error saving biodata: $e');
    }
  }

  Future<void> deleteBiodata(String id) async {
    try {
      final storage = await StorageService.getInstance();
      await storage.deleteBiodata(id);
      await loadSavedBiodatas();
    } catch (e) {
      debugPrint('Error deleting biodata: $e');
    }
  }
}
