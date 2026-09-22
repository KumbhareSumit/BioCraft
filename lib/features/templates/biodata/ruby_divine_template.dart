import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class RubyDivineTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const RubyDivineTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    const rubyPrimary = Color(0xFF7F1D1D);
    const goldAccent = Color(0xFFD97706);
    const paleRubyBg = Color(0xFFFEF2F2);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFD),
        border: Border.all(color: rubyPrimary, width: 3),
        boxShadow: [
          BoxShadow(
            color: rubyPrimary.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: goldAccent.withValues(alpha: 0.6), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Auspicious Header Mantra
            if (biodata.religionHeading.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  biodata.religionHeading,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: rubyPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: goldAccent, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '॥ शुभ विवाह बायोडेटा ॥',
                    style: GoogleFonts.cinzel(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: rubyPrimary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: goldAccent, thickness: 1)),
              ],
            ),
            const SizedBox(height: 14),

            // Name Banner
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: rubyPrimary,
              ),
            ),
            if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${biodata.highestEducation}${biodata.highestEducation.isNotEmpty && biodata.occupation.isNotEmpty ? ' • ' : ''}${biodata.occupation}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
              ),
            const SizedBox(height: 14),

            // Section 1: Personal Details
            _buildSectionBanner('PERSONAL & HOROSCOPE DETAILS', rubyPrimary, goldAccent),
            _buildDetailRow('Date of Birth', biodata.dateOfBirth),
            _buildDetailRow('Time of Birth', biodata.timeOfBirth),
            _buildDetailRow('Place of Birth', biodata.placeOfBirth),
            _buildDetailRow('Height & Complexion', '${biodata.height} ${biodata.complexion.isNotEmpty ? '• ${biodata.complexion}' : ''}'.trim()),
            _buildDetailRow('Blood Group', biodata.bloodGroup),
            _buildDetailRow('Marital Status', biodata.maritalStatus),
            _buildDetailRow('Mother Tongue', biodata.motherTongue),
            _buildDetailRow('Religion & Caste', '${biodata.religion} ${biodata.caste.isNotEmpty ? '- ${biodata.caste}' : ''} ${biodata.subCaste.isNotEmpty ? '(${biodata.subCaste})' : ''}'.trim()),
            _buildDetailRow('Gotra / Devak', biodata.gotra),
            _buildDetailRow('Rashi / Nakshatra', '${biodata.rashi} ${biodata.nakshatra.isNotEmpty ? '• Nakshatra: ${biodata.nakshatra}' : ''}'.trim()),
            _buildDetailRow('Manglik / Nadi', biodata.manglik.isNotEmpty ? 'Manglik: ${biodata.manglik}' : ''),

            const SizedBox(height: 8),

            // Section 2: Education & Career
            _buildSectionBanner('EDUCATION & OCCUPATION', rubyPrimary, goldAccent),
            _buildDetailRow('Education', biodata.highestEducation),
            _buildDetailRow('Degree Details', biodata.educationDetails),
            _buildDetailRow('Occupation', biodata.occupation),
            _buildDetailRow('Company / Firm', biodata.companyName),
            _buildDetailRow('Annual Income', biodata.annualIncome),
            _buildDetailRow('Job Location', biodata.workLocation),

            const SizedBox(height: 8),

            // Section 3: Family Details
            _buildSectionBanner('FAMILY BACKGROUND', rubyPrimary, goldAccent),
            _buildDetailRow("Father's Name", biodata.fatherName),
            _buildDetailRow("Father's Occupation", biodata.fatherOccupation),
            _buildDetailRow("Mother's Name", biodata.motherName),
            _buildDetailRow("Mother's Occupation", biodata.motherOccupation),
            _buildDetailRow('Brothers', '${biodata.brothersCount} ${biodata.brothersDetails.isNotEmpty ? '(${biodata.brothersDetails})' : ''}'.trim()),
            _buildDetailRow('Sisters', '${biodata.sistersCount} ${biodata.sistersDetails.isNotEmpty ? '(${biodata.sistersDetails})' : ''}'.trim()),
            _buildDetailRow('Family Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
            _buildDetailRow('Maternal Uncle (Mama)', biodata.maternalUncleDetails),

            const SizedBox(height: 8),

            // Section 4: Contact & Address
            _buildSectionBanner('CONTACT & RESIDENCE', rubyPrimary, goldAccent),
            _buildDetailRow('Contact Person', biodata.contactPerson),
            _buildDetailRow('Mobile Number', biodata.contactNumber),
            _buildDetailRow('Alternate Number', biodata.alternateNumber),
            _buildDetailRow('Email ID', biodata.email),
            _buildDetailRow('Address', biodata.residentialAddress),
            _buildDetailRow('Native Place', biodata.nativePlace),

            if (biodata.expectations.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildSectionBanner('EXPECTATIONS', rubyPrimary, goldAccent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: paleRubyBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: rubyPrimary.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    biodata.expectations,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionBanner(String title, Color primary, Color gold) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: gold, width: 1),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.cinzel(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.2, horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
            ),
          ),
          const Text(' :  ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
