import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../features/biodata_creator/data/models/biodata_model.dart';
import '../../features/invitation_creator/data/models/invitation_model.dart';

class PdfGenerator {
  static Future<Uint8List> generatePdfFromRenderedImage(
    Uint8List imageBytes, {
    PdfPageFormat pageFormat = PdfPageFormat.a4,
  }) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              image,
              fit: pw.BoxFit.fill,
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> generateBiodataPdf(BiodataModel biodata) async {
    final pdf = pw.Document();

    switch (biodata.templateId) {
      case 'floral_elegance':
        pdf.addPage(_buildFloralElegancePage(biodata));
        break;
      case 'modern_minimal':
        pdf.addPage(_buildModernMinimalPage(biodata));
        break;
      case 'vintage_traditional':
        pdf.addPage(_buildVintageTraditionalPage(biodata));
        break;
      case 'royal_gold':
      default:
        pdf.addPage(_buildRoyalGoldPage(biodata));
        break;
    }

    return pdf.save();
  }

  // ==========================================
  // 1. ROYAL GOLD TEMPLATE PDF
  // ==========================================
  static pw.Page _buildRoyalGoldPage(BiodataModel biodata) {
    final primaryColor = PdfColor.fromInt(biodata.primaryColorValue);
    final goldColor = PdfColor.fromInt(0xFFD4AF37);
    final darkText = PdfColor.fromInt(0xFF222222);
    final subText = PdfColor.fromInt(0xFF555555);

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: goldColor, width: 2.5),
          ),
          padding: const pw.EdgeInsets.all(14),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (biodata.religionHeading.isNotEmpty)
                pw.Text(
                  biodata.religionHeading,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(height: 1, width: 35, color: goldColor),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                    child: pw.Text(
                      'MATRIMONIAL BIODATA',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: goldColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  pw.Container(height: 1, width: 35, color: goldColor),
                ],
              ),
              pw.SizedBox(height: 8),

              // Candidate Name & Headline
              pw.Text(
                biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
                pw.Text(
                  '${biodata.highestEducation}${biodata.highestEducation.isNotEmpty && biodata.occupation.isNotEmpty ? ' | ' : ''}${biodata.occupation}',
                  style: pw.TextStyle(fontSize: 11, color: subText),
                ),
              pw.SizedBox(height: 10),

              // Sections
              _buildRoyalSectionHeader('PERSONAL DETAILS', primaryColor, goldColor),
              _buildTwoColGrid([
                _cell('Date of Birth', biodata.dateOfBirth),
                _cell('Time of Birth', biodata.timeOfBirth),
                _cell('Place of Birth', biodata.placeOfBirth),
                _cell('Height / Complexion', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' | ' : ''}${biodata.complexion}'.trim()),
                _cell('Blood Group', biodata.bloodGroup),
                _cell('Marital Status', biodata.maritalStatus),
                _cell('Mother Tongue', biodata.motherTongue),
                _cell('Religion / Caste', '${biodata.religion}${biodata.caste.isNotEmpty ? ' - ${biodata.caste}' : ''}'.trim()),
                _cell('Gotra / Rashi', '${biodata.gotra}${biodata.rashi.isNotEmpty ? ' / ${biodata.rashi}' : ''}'.trim()),
                _cell('Manglik Status', biodata.manglik),
              ]),

              pw.SizedBox(height: 8),
              _buildRoyalSectionHeader('EDUCATION & PROFESSION', primaryColor, goldColor),
              _buildTwoColGrid([
                _cell('Education', biodata.highestEducation),
                _cell('College/Uni', biodata.educationDetails),
                _cell('Occupation', biodata.occupation),
                _cell('Company', biodata.companyName),
                _cell('Annual Income', biodata.annualIncome),
                _cell('Work Location', biodata.workLocation),
              ]),

              pw.SizedBox(height: 8),
              _buildRoyalSectionHeader('FAMILY BACKGROUND', primaryColor, goldColor),
              _buildTwoColGrid([
                _cell("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
                _cell("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
                _cell('Brothers', biodata.brothersDetails.isNotEmpty ? biodata.brothersDetails : biodata.brothersCount),
                _cell('Sisters', biodata.sistersDetails.isNotEmpty ? biodata.sistersDetails : biodata.sistersCount),
                _cell('Family Type & Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
                if (biodata.maternalUncleDetails.isNotEmpty)
                  _cell('Mama / Uncle', biodata.maternalUncleDetails),
              ]),

              pw.SizedBox(height: 8),
              _buildRoyalSectionHeader('CONTACT & RESIDENCE', primaryColor, goldColor),
              _buildTwoColGrid([
                _cell('Contact Person', biodata.contactPerson),
                _cell('Phone Number', biodata.contactNumber),
                _cell('Alternate Phone', biodata.alternateNumber),
                _cell('Email Address', biodata.email),
                _cell('Address', biodata.residentialAddress),
                _cell('Native Place', biodata.nativePlace),
              ]),

              if (biodata.expectations.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                _buildRoyalSectionHeader('PARTNER EXPECTATIONS', primaryColor, goldColor),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  child: pw.Text(
                    biodata.expectations,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic, color: darkText),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  static pw.Widget _buildRoyalSectionHeader(String title, PdfColor primary, PdfColor gold) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      margin: const pw.EdgeInsets.only(bottom: 4),
      decoration: pw.BoxDecoration(
        color: primary,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        border: pw.Border.all(color: gold, width: 1),
      ),
      child: pw.Center(
        child: pw.Text(
          title,
          style: pw.TextStyle(
            color: PdfColors.white,
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 2. FLORAL ELEGANCE TEMPLATE PDF
  // ==========================================
  static pw.Page _buildFloralElegancePage(BiodataModel biodata) {
    final primaryColor = PdfColor.fromInt(biodata.primaryColorValue);
    final softTint = PdfColor.fromInt(0xFFFBF4F6);

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
            border: pw.Border.all(color: primaryColor, width: 1.5),
          ),
          padding: const pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (biodata.religionHeading.isNotEmpty)
                pw.Text(
                  biodata.religionHeading,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              pw.Text(
                '~ Marriage Biodata ~',
                style: pw.TextStyle(
                  fontSize: 15,
                  fontStyle: pw.FontStyle.italic,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
                pw.Text(
                  '${biodata.highestEducation} | ${biodata.occupation}',
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              pw.SizedBox(height: 8),

              _buildFloralSection('Personal Details', [
                _cell('Date of Birth', biodata.dateOfBirth),
                _cell('Time & Place', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
                _cell('Height & Complexion', '${biodata.height} | ${biodata.complexion}'.trim()),
                _cell('Blood Group', biodata.bloodGroup),
                _cell('Marital Status', biodata.maritalStatus),
                _cell('Mother Tongue', biodata.motherTongue),
                _cell('Religion / Caste', '${biodata.religion} - ${biodata.caste}'.trim()),
                _cell('Gotra / Rashi', '${biodata.gotra} / ${biodata.rashi}'.trim()),
              ], primaryColor, softTint),

              _buildFloralSection('Education & Career', [
                _cell('Education', biodata.highestEducation),
                _cell('University/College', biodata.educationDetails),
                _cell('Occupation', biodata.occupation),
                _cell('Company Name', biodata.companyName),
                _cell('Annual Income', biodata.annualIncome),
                _cell('Job Location', biodata.workLocation),
              ], primaryColor, softTint),

              _buildFloralSection('Family Background', [
                _cell("Father's Details", '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
                _cell("Mother's Details", '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
                _cell('Brothers', biodata.brothersDetails.isNotEmpty ? biodata.brothersDetails : biodata.brothersCount),
                _cell('Sisters', biodata.sistersDetails.isNotEmpty ? biodata.sistersDetails : biodata.sistersCount),
                _cell('Family Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
              ], primaryColor, softTint),

              _buildFloralSection('Contact Information', [
                _cell('Contact Person', biodata.contactPerson),
                _cell('Phone Number', '${biodata.contactNumber} ${biodata.alternateNumber}'.trim()),
                _cell('Email Address', biodata.email),
                _cell('Residence', biodata.residentialAddress),
              ], primaryColor, softTint),
            ],
          ),
        );
      },
    );
  }

  static pw.Widget _buildFloralSection(String title, List<Map<String, String>> items, PdfColor primary, PdfColor bg) {
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.symmetric(vertical: 4),
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        color: bg,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
        border: pw.Border.all(color: primary, width: 0.5),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 10.5,
              fontWeight: pw.FontWeight.bold,
              color: primary,
            ),
          ),
          pw.Divider(color: primary, thickness: 0.5, height: 6),
          _buildTwoColGrid(items),
        ],
      ),
    );
  }

  // ==========================================
  // 3. MODERN MINIMAL TEMPLATE PDF
  // ==========================================
  static pw.Page _buildModernMinimalPage(BiodataModel biodata) {
    final primaryColor = PdfColor.fromInt(biodata.primaryColorValue);

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300, width: 1),
          ),
          padding: const pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Banner
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: pw.BoxDecoration(
                  color: primaryColor,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (biodata.religionHeading.isNotEmpty)
                      pw.Text(
                        biodata.religionHeading,
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.white),
                      ),
                    pw.Text(
                      biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    if (biodata.occupation.isNotEmpty || biodata.highestEducation.isNotEmpty)
                      pw.Text(
                        '${biodata.occupation} | ${biodata.highestEducation}',
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.white),
                      ),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),

              _buildModernSection('Personal Details', primaryColor, [
                _cell('Date of Birth', biodata.dateOfBirth),
                _cell('Birth Time', biodata.timeOfBirth),
                _cell('Birth Place', biodata.placeOfBirth),
                _cell('Height', biodata.height),
                _cell('Complexion', biodata.complexion),
                _cell('Blood Group', biodata.bloodGroup),
                _cell('Marital Status', biodata.maritalStatus),
                _cell('Religion / Caste', '${biodata.religion} - ${biodata.caste}'.trim()),
                _cell('Gotra / Rashi', '${biodata.gotra} / ${biodata.rashi}'.trim()),
                _cell('Manglik', biodata.manglik),
              ]),

              pw.SizedBox(height: 8),
              _buildModernSection('Career & Education', primaryColor, [
                _cell('Qualification', biodata.highestEducation),
                _cell('Institute', biodata.educationDetails),
                _cell('Occupation', biodata.occupation),
                _cell('Organization', biodata.companyName),
                _cell('Income', biodata.annualIncome),
                _cell('Location', biodata.workLocation),
              ]),

              pw.SizedBox(height: 8),
              _buildModernSection('Family Information', primaryColor, [
                _cell('Father', '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
                _cell('Mother', '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
                _cell('Siblings', 'Brothers: ${biodata.brothersCount}, Sisters: ${biodata.sistersCount}'),
                _cell('Family Setup', '${biodata.familyType}, ${biodata.familyValues}'),
              ]),

              pw.SizedBox(height: 8),
              _buildModernSection('Contact Details', primaryColor, [
                _cell('Contact Person', biodata.contactPerson),
                _cell('Phone', '${biodata.contactNumber} ${biodata.alternateNumber}'.trim()),
                _cell('Email', biodata.email),
                _cell('Address', biodata.residentialAddress),
              ]),
            ],
          ),
        );
      },
    );
  }

  static pw.Widget _buildModernSection(String title, PdfColor color, List<Map<String, String>> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: color,
            letterSpacing: 1,
          ),
        ),
        pw.Container(height: 1.5, width: 28, color: color, margin: const pw.EdgeInsets.symmetric(vertical: 3)),
        _buildTwoColGrid(items),
      ],
    );
  }

  // ==========================================
  // 4. VINTAGE TRADITIONAL TEMPLATE PDF
  // ==========================================
  static pw.Page _buildVintageTraditionalPage(BiodataModel biodata) {
    final primaryColor = PdfColor.fromInt(biodata.primaryColorValue);
    final borderColor = PdfColor.fromInt(0xFFB07D62);

    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: borderColor, width: 2),
          ),
          padding: const pw.EdgeInsets.all(14),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (biodata.religionHeading.isNotEmpty)
                pw.Text(
                  biodata.religionHeading,
                  style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: primaryColor),
                ),
              pw.Text(
                'BIODATA',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: borderColor, letterSpacing: 2),
              ),
              pw.Divider(color: borderColor, thickness: 1, height: 10),

              pw.Text(
                biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: primaryColor),
              ),
              pw.SizedBox(height: 8),

              _buildTraditionalBox('PERSONAL DETAILS', borderColor, [
                _cell('Date of Birth', biodata.dateOfBirth),
                _cell('Birth Time & Place', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
                _cell('Height & Complexion', '${biodata.height} | ${biodata.complexion}'.trim()),
                _cell('Blood Group', biodata.bloodGroup),
                _cell('Religion / Caste', '${biodata.religion} - ${biodata.caste} (${biodata.subCaste})'.trim()),
                _cell('Gotra / Rashi', '${biodata.gotra} / ${biodata.rashi}'.trim()),
                _cell('Nakshatra / Manglik', '${biodata.nakshatra} | Manglik: ${biodata.manglik}'.trim()),
              ]),

              pw.SizedBox(height: 6),
              _buildTraditionalBox('EDUCATION & OCCUPATION', borderColor, [
                _cell('Qualification', biodata.highestEducation),
                _cell('College / Details', biodata.educationDetails),
                _cell('Occupation', biodata.occupation),
                _cell('Organization', biodata.companyName),
                _cell('Annual Income', biodata.annualIncome),
                _cell('Work Location', biodata.workLocation),
              ]),

              pw.SizedBox(height: 6),
              _buildTraditionalBox('FAMILY DETAILS', borderColor, [
                _cell("Father's Name", '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
                _cell("Mother's Name", '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
                _cell('Siblings', 'Brothers: ${biodata.brothersCount}, Sisters: ${biodata.sistersCount}'),
                _cell('Family Setup', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
              ]),

              pw.SizedBox(height: 6),
              _buildTraditionalBox('CONTACT & ADDRESS', borderColor, [
                _cell('Contact Person', biodata.contactPerson),
                _cell('Phone Numbers', '${biodata.contactNumber} / ${biodata.alternateNumber}'.trim()),
                _cell('Email', biodata.email),
                _cell('Address', biodata.residentialAddress),
                _cell('Native Place', biodata.nativePlace),
              ]),
            ],
          ),
        );
      },
    );
  }

  static pw.Widget _buildTraditionalBox(String title, PdfColor borderColor, List<Map<String, String>> items) {
    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: borderColor, width: 0.8),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
      ),
      padding: const pw.EdgeInsets.all(6),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Center(
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: borderColor),
            ),
          ),
          pw.Divider(color: borderColor, thickness: 0.5, height: 6),
          _buildTwoColGrid(items),
        ],
      ),
    );
  }

  // ==========================================
  // SHARED PDF HELPERS
  // ==========================================
  static Map<String, String> _cell(String label, String value) {
    return {'label': label, 'value': value};
  }

  static pw.Widget _buildTwoColGrid(List<Map<String, String>> items) {
    final valid = items.where((i) {
      final v = (i['value'] ?? '').trim();
      return v.isNotEmpty && v != '|' && v != '/' && v != '()';
    }).toList();

    return pw.Wrap(
      spacing: 12,
      runSpacing: 2,
      children: valid.map((item) {
        return pw.Container(
          width: 250,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 95,
                child: pw.Text(
                  item['label']!,
                  style: pw.TextStyle(
                    fontSize: 8.5,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(0xFF444444),
                  ),
                ),
              ),
              pw.Text(': ', style: const pw.TextStyle(fontSize: 8.5)),
              pw.Expanded(
                child: pw.Text(
                  item['value']!,
                  style: const pw.TextStyle(fontSize: 8.5),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ==========================================
  // INVITATION CARD PDF
  // ==========================================
  static Future<Uint8List> generateInvitationPdf(InvitationModel invitation) async {
    final pdf = pw.Document();
    final primaryColor = PdfColor.fromInt(invitation.primaryColorValue);
    final goldColor = PdfColor.fromInt(0xFFD4AF37);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: goldColor, width: 2),
            ),
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  invitation.titleHeading,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  invitation.hostNames,
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 18),
                pw.Text(
                  invitation.brideName,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (invitation.brideParents.isNotEmpty)
                  pw.Text(invitation.brideParents, style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 8),
                pw.Text(
                  '&',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: goldColor,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  invitation.groomName,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (invitation.groomParents.isNotEmpty)
                  pw.Text(invitation.groomParents, style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Date: ${invitation.eventDate}',
                  style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text('Time: ${invitation.eventTime}', style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 10),
                pw.Text('Venue: ${invitation.venueName}', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text(invitation.venueAddress, textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 18),
                pw.Text('RSVP: ${invitation.rsvpDetails}', style: const pw.TextStyle(fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
