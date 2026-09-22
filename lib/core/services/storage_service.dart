import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../../features/biodata_creator/data/models/biodata_model.dart';
import '../../features/invitation_creator/data/models/invitation_model.dart';
import '../../features/resume_creator/data/models/resume_model.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Biodatas
  Future<List<BiodataModel>> getSavedBiodatas() async {
    final raw = _prefs?.getStringList(AppConstants.keySavedBiodatas) ?? [];
    return raw.map((item) => BiodataModel.fromJson(item)).toList();
  }

  Future<void> saveBiodata(BiodataModel biodata) async {
    final list = await getSavedBiodatas();
    final index = list.indexWhere((item) => item.id == biodata.id);
    if (index >= 0) {
      list[index] = biodata;
    } else {
      list.insert(0, biodata);
    }
    await _prefs?.setStringList(
      AppConstants.keySavedBiodatas,
      list.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> deleteBiodata(String id) async {
    final list = await getSavedBiodatas();
    list.removeWhere((item) => item.id == id);
    await _prefs?.setStringList(
      AppConstants.keySavedBiodatas,
      list.map((e) => e.toJson()).toList(),
    );
  }

  // Invitations
  Future<List<InvitationModel>> getSavedInvitations() async {
    final raw = _prefs?.getStringList(AppConstants.keySavedInvitations) ?? [];
    return raw.map((item) => InvitationModel.fromJson(item)).toList();
  }

  Future<void> saveInvitation(InvitationModel invitation) async {
    final list = await getSavedInvitations();
    final index = list.indexWhere((item) => item.id == invitation.id);
    if (index >= 0) {
      list[index] = invitation;
    } else {
      list.insert(0, invitation);
    }
    await _prefs?.setStringList(
      AppConstants.keySavedInvitations,
      list.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> deleteInvitation(String id) async {
    final list = await getSavedInvitations();
    list.removeWhere((item) => item.id == id);
    await _prefs?.setStringList(
      AppConstants.keySavedInvitations,
      list.map((e) => e.toJson()).toList(),
    );
  }

  // Resumes
  Future<List<ResumeModel>> getSavedResumes() async {
    final raw = _prefs?.getStringList(AppConstants.keySavedResumes) ?? [];
    return raw.map((item) => ResumeModel.fromJson(item)).toList();
  }

  Future<void> saveResume(ResumeModel resume) async {
    final list = await getSavedResumes();
    final index = list.indexWhere((item) => item.id == resume.id);
    if (index >= 0) {
      list[index] = resume;
    } else {
      list.insert(0, resume);
    }
    await _prefs?.setStringList(
      AppConstants.keySavedResumes,
      list.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> deleteResume(String id) async {
    final list = await getSavedResumes();
    list.removeWhere((item) => item.id == id);
    await _prefs?.setStringList(
      AppConstants.keySavedResumes,
      list.map((e) => e.toJson()).toList(),
    );
  }
}
