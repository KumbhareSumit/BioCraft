import 'package:flutter_test/flutter_test.dart';
import 'package:biocraft/main.dart';
import 'package:biocraft/features/biodata_creator/data/models/biodata_model.dart';
import 'package:biocraft/features/invitation_creator/data/models/invitation_model.dart';
import 'package:biocraft/features/resume_creator/data/models/resume_model.dart';

void main() {
  testWidgets('App renders BioCraft title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BioCraftApp());
    await tester.pumpAndSettle();

    expect(find.text('BioCraft'), findsOneWidget);
    expect(find.text('Featured Design Templates'), findsOneWidget);
  });

  test('BiodataModel serialization and copyWith test', () {
    final bio = BiodataModel(
      id: '123',
      fullName: 'Aarav Sharma',
      occupation: 'Software Engineer',
      templateId: 'royal_gold',
    );

    expect(bio.fullName, 'Aarav Sharma');
    expect(bio.occupation, 'Software Engineer');
    expect(bio.templateId, 'royal_gold');

    final updated = bio.copyWith(fullName: 'Rohan Sharma', templateId: 'floral_elegance');
    expect(updated.fullName, 'Rohan Sharma');
    expect(updated.occupation, 'Software Engineer');
    expect(updated.templateId, 'floral_elegance');

    final json = bio.toJson();
    final restored = BiodataModel.fromJson(json);
    expect(restored.id, bio.id);
    expect(restored.fullName, bio.fullName);
  });

  test('InvitationModel serialization and copyWith test', () {
    final inv = InvitationModel.sample(type: 'Wedding');
    expect(inv.eventType, 'Wedding Invitation');
    expect(inv.brideName, 'Ananya Verma');

    final json = inv.toJson();
    final restored = InvitationModel.fromJson(json);
    expect(restored.id, inv.id);
    expect(restored.brideName, inv.brideName);
    expect(restored.eventTitle, inv.eventTitle);
  });

  test('ResumeModel serialization and copyWith test', () {
    final resume = ResumeModel.sample();
    expect(resume.fullName, 'Vikram Aditya Sharma');
    expect(resume.experiences.isNotEmpty, true);
    expect(resume.skills.contains('Flutter & Dart'), true);

    final json = resume.toJson();
    final restored = ResumeModel.fromJson(json);
    expect(restored.id, resume.id);
    expect(restored.fullName, resume.fullName);
    expect(restored.experiences.length, resume.experiences.length);
  });
}
