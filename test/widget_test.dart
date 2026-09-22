import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biocraft/main.dart';
import 'package:biocraft/features/biodata_creator/data/models/biodata_model.dart';
import 'package:biocraft/features/invitation_creator/data/models/invitation_model.dart';
import 'package:biocraft/features/resume_creator/data/models/resume_model.dart';
import 'package:biocraft/features/templates/biodata/emerald_regal_template.dart';
import 'package:biocraft/features/templates/biodata/pastel_lavender_template.dart';
import 'package:biocraft/features/templates/biodata/ruby_divine_template.dart';
import 'package:biocraft/features/templates/invitation/midnight_gold_card.dart';
import 'package:biocraft/features/templates/invitation/baby_cradle_card.dart';
import 'package:biocraft/features/templates/invitation/toran_grihapravesh_card.dart';
import 'package:biocraft/features/templates/resume/infographic_teal_resume.dart';
import 'package:biocraft/features/templates/resume/academic_scholar_resume.dart';
import 'package:biocraft/features/templates/resume/compact_grid_resume.dart';

void main() {
  testWidgets('App renders BioCraft title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BioCraftApp());
    await tester.pumpAndSettle();

    expect(find.text('BioCraft'), findsOneWidget);
    expect(find.text('Featured Design Templates'), findsOneWidget);
  });

  testWidgets('Renders all 9 new templates without overflow', (WidgetTester tester) async {
    final bio = BiodataModel(id: '1', fullName: 'Test Name', templateId: 'emerald_regal');
    final inv = InvitationModel.sample(type: 'Wedding');
    final res = ResumeModel.sample();

    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          child: Column(
            children: [
              EmeraldRegalTemplate(biodata: bio),
              PastelLavenderTemplate(biodata: bio),
              RubyDivineTemplate(biodata: bio),
              MidnightGoldCard(invitation: inv),
              BabyCradleCard(invitation: inv),
              ToranGrihapraveshCard(invitation: inv),
              InfographicTealResume(resume: res),
              AcademicScholarResume(resume: res),
              CompactGridResume(resume: res),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(EmeraldRegalTemplate), findsOneWidget);
    expect(find.byType(PastelLavenderTemplate), findsOneWidget);
    expect(find.byType(RubyDivineTemplate), findsOneWidget);
    expect(find.byType(MidnightGoldCard), findsOneWidget);
    expect(find.byType(BabyCradleCard), findsOneWidget);
    expect(find.byType(ToranGrihapraveshCard), findsOneWidget);
    expect(find.byType(InfographicTealResume), findsOneWidget);
    expect(find.byType(AcademicScholarResume), findsOneWidget);
    expect(find.byType(CompactGridResume), findsOneWidget);
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
