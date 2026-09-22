import 'package:flutter/foundation.dart';
import '../../../core/services/storage_service.dart';
import '../data/models/invitation_model.dart';

class InvitationProvider with ChangeNotifier {
  InvitationModel _currentInvitation = InvitationModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
  );

  List<InvitationModel> _savedInvitations = [];
  bool _isLoading = false;

  InvitationModel get currentInvitation => _currentInvitation;
  List<InvitationModel> get savedInvitations => _savedInvitations;
  bool get isLoading => _isLoading;

  InvitationProvider() {
    loadSavedInvitations();
  }

  void updateInvitation(InvitationModel updated) {
    _currentInvitation = updated;
    notifyListeners();
  }

  void updateField(InvitationModel Function(InvitationModel current) updateFn) {
    _currentInvitation = updateFn(_currentInvitation);
    notifyListeners();
  }

  void createNewInvitation() {
    _currentInvitation = InvitationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    notifyListeners();
  }

  void loadInvitation(InvitationModel invitation) {
    _currentInvitation = invitation;
    notifyListeners();
  }

  void loadSampleInvitation() {
    _currentInvitation = InvitationModel.sample();
    notifyListeners();
  }

  Future<void> loadSavedInvitations() async {
    _isLoading = true;
    notifyListeners();
    try {
      final storage = await StorageService.getInstance();
      _savedInvitations = await storage.getSavedInvitations();
    } catch (e) {
      debugPrint('Error loading invitations: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCurrentInvitation() async {
    try {
      final storage = await StorageService.getInstance();
      await storage.saveInvitation(_currentInvitation);
      await loadSavedInvitations();
    } catch (e) {
      debugPrint('Error saving invitation: $e');
    }
  }

  Future<void> deleteInvitation(String id) async {
    try {
      final storage = await StorageService.getInstance();
      await storage.deleteInvitation(id);
      await loadSavedInvitations();
    } catch (e) {
      debugPrint('Error deleting invitation: $e');
    }
  }
}
