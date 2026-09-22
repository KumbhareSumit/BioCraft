import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class EmeraldRegalTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const EmeraldRegalTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    const emeraldPrimary = Color(0xFF064E3B);
    const goldAccent = Color(0xFFD4AF37);
    const softEmerald = Color(0xFFECFDF5);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFD),
        border: Border.all(color: emeraldPrimary, width: 3.5),
        boxShadow: [
          BoxShadow(
            color: emeraldPrimary.withValues(alpha: 0.15),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: goldAccent.withValues(alpha: 0.5), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Religion Mantra
            if (biodata.religionHeading.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  biodata.religionHeading,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: emeraldPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

            // Ornate Header Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: emeraldPrimary,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: goldAccent),
              ),
              child: Text(
                '✦ MATRIMONIAL BIODATA ✦',
                style: GoogleFonts.cinzel(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: goldAccent,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Candidate Name & Highlight
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: emeraldPrimary,
              ),
            ),
            if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 3),
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
            _buildSectionHeader('PERSONAL PROFILE', emeraldPrimary, goldAccent),
            _buildDetailRow('Date of Birth', biodata.dateOfBirth),
            _buildDetailRow('Time of Birth', biodata.timeOfBirth),
            _buildDetailRow('Place of Birth', biodata.placeOfBirth),
            _buildDetailRow('Height', biodata.height),
            _buildDetailRow('Complexion', biodata.complexion),
            _buildDetailRow('Blood Group', biodata.bloodGroup),
            _buildDetailRow('Marital Status', biodata.maritalStatus),
            _buildDetailRow('Mother Tongue', biodata.motherTongue),
            _buildDetailRow('Religion / Caste', '${biodata.religion} ${biodata.caste.isNotEmpty ? '- ${biodata.caste}' : ''} ${biodata.subCaste.isNotEmpty ? '(${biodata.subCaste})' : ''}'.trim()),
            _buildDetailRow('Gotra / Rashi', '${biodata.gotra} ${biodata.rashi.isNotEmpty ? '/ ${biodata.rashi}' : ''}'.trim()),
            _buildDetailRow('Nakshatra / Manglik', '${biodata.nakshatra} ${biodata.manglik.isNotEmpty ? '• Manglik: ${biodata.manglik}' : ''}'.trim()),

            const SizedBox(height: 8),

            // Section 2: Education & Career
            _buildSectionHeader('EDUCATION & PROFESSION', emeraldPrimary, goldAccent),
            _buildDetailRow('Education', biodata.highestEducation),
            _buildDetailRow('Degree / Details', biodata.educationDetails),
            _buildDetailRow('Occupation', biodata.occupation),
            _buildDetailRow('Employed In / Org', biodata.companyName),
            _buildDetailRow('Annual Income', biodata.annualIncome),
            _buildDetailRow('Work Location', biodata.workLocation),

            const SizedBox(height: 8),

            // Section 3: Family Details
            _buildSectionHeader('FAMILY BACKGROUND', emeraldPrimary, goldAccent),
            _buildDetailRow("Father's Name", biodata.fatherName),
            _buildDetailRow("Father's Occupation", biodata.fatherOccupation),
            _buildDetailRow("Mother's Name", biodata.motherName),
            _buildDetailRow("Mother's Occupation", biodata.motherOccupation),
            _buildDetailRow('Brothers', '${biodata.brothersCount} ${biodata.brothersDetails.isNotEmpty ? '(${biodata.brothersDetails})' : ''}'.trim()),
            _buildDetailRow('Sisters', '${biodata.sistersCount} ${biodata.sistersDetails.isNotEmpty ? '(${biodata.sistersDetails})' : ''}'.trim()),
            _buildDetailRow('Family Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
            _buildDetailRow('Maternal Uncle (Mama)', biodata.maternalUncleDetails),

            const SizedBox(height: 8),

            // Section 4: Contact & Location
            _buildSectionHeader('CONTACT & CORRESPONDENCE', emeraldPrimary, goldAccent),
            _buildDetailRow('Contact Person', biodata.contactPerson),
            _buildDetailRow('Primary Phone', biodata.contactNumber),
            _buildDetailRow('Alternate Phone', biodata.alternateNumber),
            _buildDetailRow('Email', biodata.email),
            _buildDetailRow('Residential Address', biodata.residentialAddress),
            _buildDetailRow('Native Place', biodata.nativePlace),

            if (biodata.expectations.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildSectionHeader('PARTNER EXPECTATIONS', emeraldPrimary, goldAccent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: softEmerald,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: emeraldPrimary.withValues(alpha: 0.2)),
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

  Widget _buildSectionHeader(String title, Color primary, Color gold) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: gold,
              letterSpacing: 1.2,
            ),
          ),
          Icon(Icons.spa, size: 12, color: gold),
        ],
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
            width: 110,
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
