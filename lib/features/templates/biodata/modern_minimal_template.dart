import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class ModernMinimalTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const ModernMinimalTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minimalist Header Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (biodata.religionHeading.isNotEmpty)
                        Text(
                          biodata.religionHeading,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Text(
                        biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasPhoto) ...[
                  const SizedBox(width: 14),
                  BiodataPhotoFrame(
                    imagePath: biodata.profileImagePath,
                    width: 85,
                    height: 105,
                    borderRadius: 6,
                    borderWidth: 2,
                    borderColor: Colors.white,
                    showShadow: false,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),


          _buildGridSection('Personal Info', [
            _item('Date of Birth', biodata.dateOfBirth),
            _item('Birth Time', biodata.timeOfBirth),
            _item('Birth Place', biodata.placeOfBirth),
            _item('Height', biodata.height),
            _item('Complexion', biodata.complexion),
            _item('Marital Status', biodata.maritalStatus),
            _item('Caste', '${biodata.religion}${biodata.caste.isNotEmpty ? ' - ${biodata.caste}' : ''}'.trim()),
            _item('Gotra / Devak', biodata.displayGotraDevak),
            _item('Rashi / Nakshatra', biodata.displayRashiNakshatra),
            _item('Manglik / Nadi', biodata.displayManglikNadi),
            if (biodata.displayGanKuldaivat.isNotEmpty)
              _item('Gan / Kuldaivat', biodata.displayGanKuldaivat),
          ], primaryColor),

          const SizedBox(height: 12),

          _buildGridSection('Professional Info', [
            _item('Highest Degree', biodata.highestEducation),
            _item('Occupation', biodata.occupation),
            _item('Employer / Org', biodata.companyName),
            _item('Annual CTC', biodata.annualIncome),
            _item('Location', biodata.workLocation),
          ], primaryColor),

          const SizedBox(height: 12),

          _buildGridSection('Family Details', [
            _item('Father\'s Name', biodata.fatherName),
            _item('Father Occupation', biodata.fatherOccupation),
            _item('Mother\'s Name', biodata.motherName),
            _item('Mother Occupation', biodata.motherOccupation),
            if (biodata.hasBrothers) _item('Brothers', biodata.displayBrothers),
            if (biodata.hasSisters) _item('Sisters', biodata.displaySisters),
            if (biodata.hasFamilyType) _item('Family Type', biodata.displayFamilyType),
            if (biodata.hasFamilyValues) _item('Family Values', biodata.displayFamilyValues),
          ], primaryColor),

          const SizedBox(height: 12),

          _buildGridSection('Contact Info', [
            _item('Contact Person', biodata.contactPerson),
            _item(biodata.primaryContactLabel, biodata.displayPrimaryContact),
            _item(biodata.alternateContactLabel, biodata.displayAlternateContact),
            _item('Email', biodata.email),
            _item('Address', biodata.residentialAddress),
          ], primaryColor),
        ],
      ),
    );
  }

  Widget _buildGridSection(String title, List<Widget> items, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final itemWidth = (availableWidth - 12) / 2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 14, color: color),
                const SizedBox(width: 6),
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: items.map((widget) {
                return SizedBox(
                  width: itemWidth > 110 ? itemWidth : availableWidth,
                  child: widget,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _item(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
