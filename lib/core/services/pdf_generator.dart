import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../features/biodata_creator/data/models/biodata_model.dart';
import '../../features/invitation_creator/data/models/invitation_model.dart';

class PdfGenerator {
  static Future<Uint8List> generateBiodataPdf(BiodataModel biodata) async {
    final pdf = pw.Document();

    final primaryColor = PdfColor.fromInt(biodata.primaryColorValue);
    final goldColor = PdfColor.fromInt(0xFFD4AF37);
    final darkText = PdfColor.fromInt(0xFF222222);
    final subText = PdfColor.fromInt(0xFF555555);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: goldColor, width: 2),
            ),
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Header
                if (biodata.religionHeading.isNotEmpty)
                  pw.Text(
                    biodata.religionHeading,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                pw.SizedBox(height: 6),
                pw.Text(
                  'MATRIMONIAL BIODATA',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
                pw.Divider(color: goldColor, thickness: 1.5),
                pw.SizedBox(height: 10),

                // Name & Headline
                pw.Text(
                  biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: darkText,
                  ),
                ),
                if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
                  pw.Text(
                    '${biodata.highestEducation} | ${biodata.occupation}',
                    style: pw.TextStyle(fontSize: 12, color: subText),
                  ),
                pw.SizedBox(height: 14),

                // Section 1: Personal Details
                _buildSectionHeader('PERSONAL DETAILS', primaryColor),
                _buildRow('Date of Birth', biodata.dateOfBirth),
                _buildRow('Time & Place', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
                _buildRow('Height & Complexion', '${biodata.height} | ${biodata.complexion}'.trim()),
                _buildRow('Marital Status', biodata.maritalStatus),
                _buildRow('Religion / Caste', '${biodata.religion} - ${biodata.caste} (${biodata.subCaste})'.trim()),
                _buildRow('Gotra / Rashi', '${biodata.gotra} / ${biodata.rashi}'.trim()),
                _buildRow('Manglik Status', biodata.manglik),

                pw.SizedBox(height: 10),

                // Section 2: Education & Career
                _buildSectionHeader('EDUCATION & PROFESSION', primaryColor),
                _buildRow('Education', biodata.highestEducation),
                _buildRow('Occupation', biodata.occupation),
                _buildRow('Company & Location', '${biodata.companyName} (${biodata.workLocation})'.trim()),
                _buildRow('Annual Income', biodata.annualIncome),

                pw.SizedBox(height: 10),

                // Section 3: Family Details
                _buildSectionHeader('FAMILY BACKGROUND', primaryColor),
                _buildRow('Father\'s Name', '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
                _buildRow('Mother\'s Name', '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
                _buildRow('Siblings', 'Brothers: ${biodata.brothersCount}, Sisters: ${biodata.sistersCount}'),
                _buildRow('Family Type & Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),

                pw.SizedBox(height: 10),

                // Section 4: Contact & Address
                _buildSectionHeader('CONTACT DETAILS', primaryColor),
                _buildRow('Contact Person', biodata.contactPerson),
                _buildRow('Phone / WhatsApp', '${biodata.contactNumber} ${biodata.alternateNumber}'.trim()),
                _buildRow('Email', biodata.email),
                _buildRow('Address', biodata.residentialAddress),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildSectionHeader(String title, PdfColor color) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      margin: const pw.EdgeInsets.only(bottom: 4),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _buildRow(String label, String value) {
    if (value.trim().isEmpty || value.trim() == '|' || value.trim() == '/') {
      return pw.SizedBox.shrink();
    }
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF444444),
              ),
            ),
          ),
          pw.Text(':  ', style: const pw.TextStyle(fontSize: 9)),
          pw.Expanded(
            child: pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }

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
