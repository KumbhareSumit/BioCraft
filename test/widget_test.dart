import 'package:flutter_test/flutter_test.dart';
import 'package:biocraft/main.dart';
import 'package:biocraft/features/biodata_creator/data/models/biodata_model.dart';

void main() {
  testWidgets('App renders BioCraft title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BioCraftApp());
    await tester.pumpAndSettle();

    expect(find.text('BioCraft'), findsOneWidget);
    expect(find.text('Featured Biodata Templates'), findsOneWidget);
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
}
