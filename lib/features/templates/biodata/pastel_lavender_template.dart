import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class PastelLavenderTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const PastelLavenderTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final lavenderPrimary = Color(biodata.primaryColorValue);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;
    const softLilacBg = Color(0xFFF5F3FF);
    const cardBorder = Color(0xFFDDD6FE);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
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

          if (hasPhoto)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                      decoration: BoxDecoration(
                        color: softLilacBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: cardBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MARRIAGE BIODATA',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8B5CF6),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                            style: GoogleFonts.outfit(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4C1D95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  BiodataPhotoFrame(
                    imagePath: biodata.profileImagePath,
                    width: 90,
                    height: 115,
                    borderRadius: 12,
                    borderColor: lavenderPrimary,
                    innerBorderColor: cardBorder,
                  ),
                ],
              ),
            )
          else ...[
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
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Sections in neat cards
          _buildCardSection(
            title: 'Personal & Astrological Details',
            icon: Icons.person_outline,
            primaryColor: lavenderPrimary,
            items: [
              MapEntry('Date of Birth', biodata.dateOfBirth),
              MapEntry('Time of Birth', biodata.timeOfBirth),
              MapEntry('Place of Birth', biodata.placeOfBirth),
              MapEntry('Height / Complexion', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' • ' : ''}${biodata.complexion}'.trim()),
              MapEntry('Blood Group', biodata.bloodGroup),
              MapEntry('Marital Status', biodata.maritalStatus),
              MapEntry('Mother Tongue', biodata.motherTongue),
              MapEntry('Religion & Caste', '${biodata.religion}${biodata.caste.isNotEmpty ? ' - ${biodata.caste}' : ''}${biodata.subCaste.isNotEmpty ? ' (${biodata.subCaste})' : ''}'.trim()),
              MapEntry('Gotra / Devak', biodata.displayGotraDevak),
              MapEntry('Rashi / Nakshatra', biodata.displayRashiNakshatra),
              MapEntry('Manglik / Nadi', biodata.displayManglikNadi),
              if (biodata.displayGanKuldaivat.isNotEmpty)
                MapEntry('Gan / Kuldaivat', biodata.displayGanKuldaivat),
            ],
          ),

          const SizedBox(height: 8),

          _buildCardSection(
            title: 'Education & Professional Details',
            icon: Icons.school_outlined,
            primaryColor: lavenderPrimary,
            items: [
              MapEntry('Highest Education', biodata.highestEducation),
              MapEntry('Degree Details', biodata.educationDetails),
              MapEntry('Occupation', biodata.occupation),
              MapEntry('Organization', biodata.companyName),
              MapEntry('Annual Income', biodata.annualIncome),
              MapEntry('Work Location', biodata.workLocation),
            ],
          ),

          const SizedBox(height: 8),

          _buildCardSection(
            title: 'Family Background',
            icon: Icons.family_restroom_outlined,
            primaryColor: lavenderPrimary,
            items: [
              MapEntry("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
              MapEntry("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
              if (biodata.hasBrothers) MapEntry('Brothers', biodata.displayBrothers),
              if (biodata.hasSisters) MapEntry('Sisters', biodata.displaySisters),
              if (biodata.hasFamilyType) MapEntry('Family Type', biodata.displayFamilyType),
              if (biodata.hasFamilyValues) MapEntry('Family Values', biodata.displayFamilyValues),
            ],
            fullWidthItem: biodata.maternalUncleDetails.isNotEmpty ? MapEntry('Mama (Uncle)', biodata.maternalUncleDetails) : null,
          ),

          const SizedBox(height: 8),

          _buildCardSection(
            title: 'Contact Information',
            icon: Icons.contact_phone_outlined,
            primaryColor: lavenderPrimary,
            items: [
              MapEntry('Contact Person', biodata.contactPerson),
              MapEntry(biodata.primaryContactLabel, biodata.displayPrimaryContact),
              MapEntry(biodata.alternateContactLabel, biodata.displayAlternateContact),
              MapEntry('Email ID', biodata.email),
              MapEntry('Native Place', biodata.nativePlace),
            ],
            fullWidthItem: biodata.residentialAddress.isNotEmpty ? MapEntry('Current Address', biodata.residentialAddress) : null,
          ),

          if (biodata.expectations.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
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
                      Icon(Icons.favorite_border, size: 14, color: lavenderPrimary),
                      const SizedBox(width: 6),
                      Text(
                        'Partner Expectations',
                        style: GoogleFonts.outfit(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: lavenderPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFFDDD6FE), thickness: 0.8, height: 10),
                  Text(
                    biodata.expectations,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF374151),
                    ),
                  ),
                ],
              ),
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
    required List<MapEntry<String, String>> items,
    MapEntry<String, String>? fullWidthItem,
  }) {
    final valid = items.where((e) => e.value.trim().isNotEmpty).toList();
    if (valid.isEmpty && (fullWidthItem == null || fullWidthItem.value.trim().isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFDDD6FE), thickness: 0.8, height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 3,
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
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                    const Text(' :  ', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    Expanded(
                      child: Text(
                        e.value,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          if (fullWidthItem != null && fullWidthItem.value.trim().isNotEmpty) ...[
            const SizedBox(height: 3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 95,
                  child: Text(
                    fullWidthItem.key,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
                const Text(' :  ', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                Expanded(
                  child: Text(
                    fullWidthItem.value,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
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
}
