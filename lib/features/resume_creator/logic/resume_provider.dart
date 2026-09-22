import 'package:flutter/foundation.dart';
import '../../../core/services/storage_service.dart';
import '../data/models/resume_model.dart';

class ResumeProvider with ChangeNotifier {
  ResumeModel _currentResume = ResumeModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
  );

  List<ResumeModel> _savedResumes = [];
  bool _isLoading = false;
  int _currentStep = 0;

  ResumeModel get currentResume => _currentResume;
  List<ResumeModel> get savedResumes => _savedResumes;
  bool get isLoading => _isLoading;
  int get currentStep => _currentStep;

  ResumeProvider() {
    loadSavedResumes();
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

  void updateResume(ResumeModel updated) {
    _currentResume = updated;
    notifyListeners();
  }

  void updateField(ResumeModel Function(ResumeModel current) updateFn) {
    _currentResume = updateFn(_currentResume);
    notifyListeners();
  }

  void createNewResume() {
    _currentResume = ResumeModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _currentStep = 0;
    notifyListeners();
  }

  void loadResume(ResumeModel resume) {
    _currentResume = resume;
    _currentStep = 0;
    notifyListeners();
  }

  void loadSampleResume() {
    _currentResume = ResumeModel.sample();
    _currentStep = 0;
    notifyListeners();
  }

  Future<void> loadSavedResumes() async {
    _isLoading = true;
    notifyListeners();
    try {
      final storage = await StorageService.getInstance();
      _savedResumes = await storage.getSavedResumes();
    } catch (e) {
      debugPrint('Error loading saved resumes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCurrentResume() async {
    try {
      final storage = await StorageService.getInstance();
      await storage.saveResume(_currentResume);
      await loadSavedResumes();
    } catch (e) {
      debugPrint('Error saving resume: $e');
    }
  }

  Future<void> deleteResume(String id) async {
    try {
      final storage = await StorageService.getInstance();
      await storage.deleteResume(id);
      await loadSavedResumes();
    } catch (e) {
      debugPrint('Error deleting resume: $e');
    }
  }
}
