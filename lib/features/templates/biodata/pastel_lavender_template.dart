import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class PastelLavenderTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const PastelLavenderTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    const lavenderPrimary = Color(0xFF6D28D9);
    const softLilacBg = Color(0xFFFAF5FF);
    const cardBorder = Color(0xFFE9D5FF);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: lavenderPrimary.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Mantra / Heading
          if (biodata.religionHeading.isNotEmpty)
            Text(
              biodata.religionHeading,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: lavenderPrimary,
                letterSpacing: 1.2,
              ),
            ),
          const SizedBox(height: 4),

          Text(
            'MARRIAGE BIODATA',
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF8B5CF6),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),

          // Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: softLilacBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cardBorder),
            ),
            child: Column(
              children: [
                Text(
                  biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4C1D95),
                  ),
                ),
                if (biodata.highestEducation.isNotEmpty || biodata.occupation.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${biodata.highestEducation}${biodata.highestEducation.isNotEmpty && biodata.occupation.isNotEmpty ? ' • ' : ''}${biodata.occupation}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Sections in neat cards
          _buildCardSection(
            title: 'Personal & Astrological Details',
            icon: Icons.person_outline,
            primaryColor: lavenderPrimary,
            children: [
              _buildDetailRow('Date of Birth', biodata.dateOfBirth),
              _buildDetailRow('Time of Birth', biodata.timeOfBirth),
              _buildDetailRow('Place of Birth', biodata.placeOfBirth),
              _buildDetailRow('Height', biodata.height),
              _buildDetailRow('Complexion', biodata.complexion),
              _buildDetailRow('Blood Group', biodata.bloodGroup),
              _buildDetailRow('Marital Status', biodata.maritalStatus),
              _buildDetailRow('Mother Tongue', biodata.motherTongue),
              _buildDetailRow('Religion & Caste', '${biodata.religion} ${biodata.caste.isNotEmpty ? '- ${biodata.caste}' : ''} ${biodata.subCaste.isNotEmpty ? '(${biodata.subCaste})' : ''}'.trim()),
              _buildDetailRow('Gotra & Rashi', '${biodata.gotra} ${biodata.rashi.isNotEmpty ? '/ ${biodata.rashi}' : ''}'.trim()),
              _buildDetailRow('Nakshatra / Manglik', '${biodata.nakshatra} ${biodata.manglik.isNotEmpty ? '• Manglik: ${biodata.manglik}' : ''}'.trim()),
            ],
          ),

          const SizedBox(height: 10),

          _buildCardSection(
            title: 'Education & Professional Details',
            icon: Icons.school_outlined,
            primaryColor: lavenderPrimary,
            children: [
              _buildDetailRow('Highest Education', biodata.highestEducation),
              _buildDetailRow('Degree Details', biodata.educationDetails),
              _buildDetailRow('Occupation', biodata.occupation),
              _buildDetailRow('Organization', biodata.companyName),
              _buildDetailRow('Annual Income', biodata.annualIncome),
              _buildDetailRow('Work Location', biodata.workLocation),
            ],
          ),

          const SizedBox(height: 10),

          _buildCardSection(
            title: 'Family Background',
            icon: Icons.family_restroom_outlined,
            primaryColor: lavenderPrimary,
            children: [
              _buildDetailRow("Father's Name", biodata.fatherName),
              _buildDetailRow("Father's Profession", biodata.fatherOccupation),
              _buildDetailRow("Mother's Name", biodata.motherName),
              _buildDetailRow("Mother's Profession", biodata.motherOccupation),
              _buildDetailRow('Brothers', '${biodata.brothersCount} ${biodata.brothersDetails.isNotEmpty ? '(${biodata.brothersDetails})' : ''}'.trim()),
              _buildDetailRow('Sisters', '${biodata.sistersCount} ${biodata.sistersDetails.isNotEmpty ? '(${biodata.sistersDetails})' : ''}'.trim()),
              _buildDetailRow('Family Culture', '${biodata.familyType} Family • ${biodata.familyValues} Values'),
              _buildDetailRow('Mama (Uncle)', biodata.maternalUncleDetails),
            ],
          ),

          const SizedBox(height: 10),

          _buildCardSection(
            title: 'Contact Information',
            icon: Icons.contact_phone_outlined,
            primaryColor: lavenderPrimary,
            children: [
              _buildDetailRow('Contact Person', biodata.contactPerson),
              _buildDetailRow('Primary Mobile', biodata.contactNumber),
              _buildDetailRow('Alternate Contact', biodata.alternateNumber),
              _buildDetailRow('Email ID', biodata.email),
              _buildDetailRow('Current Address', biodata.residentialAddress),
              _buildDetailRow('Native Place', biodata.nativePlace),
            ],
          ),

          if (biodata.expectations.isNotEmpty) ...[
            const SizedBox(height: 10),
            _buildCardSection(
              title: 'Partner Expectations',
              icon: Icons.favorite_border,
              primaryColor: lavenderPrimary,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    biodata.expectations,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF374151),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required IconData icon,
    required Color primaryColor,
    required List<Widget> children,
  }) {
    final validChildren = children.where((w) => w is! SizedBox || (w.width != 0 && w.height != 0)).toList();
    if (validChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: primaryColor),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFDDD6FE), thickness: 0.8, height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          const Text(' :  ', style: TextStyle(fontSize: 11.5, color: Color(0xFF9CA3AF))),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
