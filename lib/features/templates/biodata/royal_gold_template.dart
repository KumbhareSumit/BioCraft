import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class RoyalGoldTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const RoyalGoldTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const gold = Color(0xFFD4AF37);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;

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
          
          if (hasPhoto)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'MATRIMONIAL BIODATA',
                              style: GoogleFonts.cinzel(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: gold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Container(height: 1, color: gold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                          style: GoogleFonts.cinzel(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  BiodataPhotoFrame(
                    imagePath: biodata.profileImagePath,
                    width: 92,
                    height: 118,
                    borderColor: gold,
                    innerBorderColor: primaryColor.withValues(alpha: 0.6),
                  ),
                ],
              ),
            )
          else ...[
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
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
          ],


          // Section 1: Personal Details
          _buildSectionHeader('PERSONAL DETAILS', primaryColor, gold),
          _buildGrid([
            MapEntry('Date of Birth', biodata.dateOfBirth),
            MapEntry('Time of Birth', biodata.timeOfBirth),
            MapEntry('Place of Birth', biodata.placeOfBirth),
            MapEntry('Height / Complexion', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' • ' : ''}${biodata.complexion}'.trim()),
            MapEntry('Blood Group', biodata.bloodGroup),
            MapEntry('Marital Status', biodata.maritalStatus),
            MapEntry('Mother Tongue', biodata.motherTongue),
            MapEntry('Religion / Caste', '${biodata.religion}${biodata.caste.isNotEmpty ? ' - ${biodata.caste}' : ''}${biodata.subCaste.isNotEmpty ? ' (${biodata.subCaste})' : ''}'.trim()),
            MapEntry('Gotra / Rashi', '${biodata.gotra}${biodata.rashi.isNotEmpty ? ' / ${biodata.rashi}' : ''}'.trim()),
            MapEntry('Manglik Status', biodata.manglik),
          ]),

          const SizedBox(height: 8),

          // Section 2: Education & Career
          _buildSectionHeader('EDUCATION & PROFESSION', primaryColor, gold),
          _buildGrid([
            MapEntry('Highest Education', biodata.highestEducation),
            MapEntry('Education Details', biodata.educationDetails),
            MapEntry('Occupation', biodata.occupation),
            MapEntry('Organization', biodata.companyName),
            MapEntry('Annual Income', biodata.annualIncome),
            MapEntry('Work Location', biodata.workLocation),
          ]),

          const SizedBox(height: 8),

          // Section 3: Family Details
          _buildSectionHeader('FAMILY BACKGROUND', primaryColor, gold),
          _buildGrid([
            MapEntry("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
            MapEntry("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
            MapEntry('Brothers', biodata.displayBrothers),
            MapEntry('Sisters', biodata.displaySisters),
            MapEntry('Family Setup', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
          ]),
          if (biodata.maternalUncleDetails.isNotEmpty)
            _buildFullWidthRow('Mama / Uncle', biodata.maternalUncleDetails),

          const SizedBox(height: 8),

          // Section 4: Contact & Address
          _buildSectionHeader('CONTACT & RESIDENCE', primaryColor, gold),
          _buildGrid([
            MapEntry('Contact Person', biodata.contactPerson),
            MapEntry('Contact Number', biodata.displayPrimaryContact),
            MapEntry('Alternate Number', biodata.displayAlternateContact),
            MapEntry('Email Address', biodata.email),
            MapEntry('Native Place', biodata.nativePlace),
          ]),
          if (biodata.residentialAddress.isNotEmpty)
            _buildFullWidthRow('Address', biodata.residentialAddress),

          if (biodata.expectations.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildSectionHeader('PARTNER EXPECTATIONS', primaryColor, gold),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                biodata.expectations,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 11,
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 8),
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

  Widget _buildGrid(List<MapEntry<String, String>> items) {
    final valid = items.where((e) => e.value.trim().isNotEmpty).toList();
    if (valid.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Wrap(
        spacing: 12,
        runSpacing: 4,
        children: valid.map((e) {
          return SizedBox(
            width: 248,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 95,
                  child: Text(
                    e.key,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4A4A4A),
                    ),
                  ),
                ),
                const Text(' :  ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                Expanded(
                  child: Text(
                    e.value,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFullWidthRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
            ),
          ),
          const Text(' :  ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 11,
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
