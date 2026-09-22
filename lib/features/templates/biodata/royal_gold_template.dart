import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class RoyalGoldTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const RoyalGoldTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const gold = Color(0xFFD4AF37);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        border: Border.all(color: gold, width: 3),
        boxShadow: [
          BoxShadow(
            color: gold.withValues(alpha: 0.2),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Symbol & Heading
          if (biodata.religionHeading.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                biodata.religionHeading,
                style: GoogleFonts.cinzel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Expanded(child: Container(height: 1, color: gold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'MATRIMONIAL BIODATA',
                    style: GoogleFonts.cinzel(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: gold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(child: Container(height: 1, color: gold)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Name & Occupation Tag
          Text(
            biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
            style: GoogleFonts.cinzel(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty)
            Text(
              '${biodata.highestEducation}${biodata.highestEducation.isNotEmpty && biodata.occupation.isNotEmpty ? ' • ' : ''}${biodata.occupation}',
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          const SizedBox(height: 16),

          // Section 1: Personal Details
          _buildSectionHeader('PERSONAL DETAILS', primaryColor, gold),
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
          _buildDetailRow('Manglik Status', biodata.manglik),

          const SizedBox(height: 14),

          // Section 2: Education & Career
          _buildSectionHeader('EDUCATION & PROFESSION', primaryColor, gold),
          _buildDetailRow('Highest Education', biodata.highestEducation),
          _buildDetailRow('Education Details', biodata.educationDetails),
          _buildDetailRow('Occupation', biodata.occupation),
          _buildDetailRow('Organization', biodata.companyName),
          _buildDetailRow('Annual Income', biodata.annualIncome),
          _buildDetailRow('Work Location', biodata.workLocation),

          const SizedBox(height: 14),

          // Section 3: Family Details
          _buildSectionHeader('FAMILY BACKGROUND', primaryColor, gold),
          _buildDetailRow('Father\'s Name', biodata.fatherName),
          _buildDetailRow('Father\'s Occupation', biodata.fatherOccupation),
          _buildDetailRow('Mother\'s Name', biodata.motherName),
          _buildDetailRow('Mother\'s Occupation', biodata.motherOccupation),
          _buildDetailRow('Brothers', biodata.brothersDetails.isNotEmpty ? biodata.brothersDetails : biodata.brothersCount),
          _buildDetailRow('Sisters', biodata.sistersDetails.isNotEmpty ? biodata.sistersDetails : biodata.sistersCount),
          _buildDetailRow('Family Type / Values', '${biodata.familyType} Family, ${biodata.familyValues} Values'),

          const SizedBox(height: 14),

          // Section 4: Contact & Address
          _buildSectionHeader('CONTACT & RESIDENCE', primaryColor, gold),
          _buildDetailRow('Contact Person', biodata.contactPerson),
          _buildDetailRow('Contact Number', biodata.contactNumber),
          _buildDetailRow('Alternate Number', biodata.alternateNumber),
          _buildDetailRow('Email Address', biodata.email),
          _buildDetailRow('Residential Address', biodata.residentialAddress),
          _buildDetailRow('Native Place', biodata.nativePlace),

          if (biodata.expectations.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildSectionHeader('PARTNER EXPECTATIONS', primaryColor, gold),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                biodata.expectations,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color primary, Color gold) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
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
            fontSize: 12,
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
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4),
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
