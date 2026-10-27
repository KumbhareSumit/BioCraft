import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class FloralEleganceTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const FloralEleganceTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const softRose = Color(0xFFFDE8EC);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withValues(alpha: 0.3), width: 2),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Floral Motif Icon
          Icon(Icons.spa_outlined, color: primaryColor, size: 28),
          const SizedBox(height: 4),
          if (biodata.religionHeading.isNotEmpty)
            Text(
              biodata.religionHeading,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          if (hasPhoto)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  BiodataPhotoFrame(
                    imagePath: biodata.profileImagePath,
                    width: 90,
                    height: 115,
                    borderRadius: 12,
                    borderColor: primaryColor.withValues(alpha: 0.6),
                    innerBorderColor: const Color(0xFFD4AF37),
                  ),
                ],
              ),
            )
          else ...[
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
          ],

          _buildSection('Personal Information', [
            MapEntry('Date of Birth', biodata.dateOfBirth),
            MapEntry('Time & Place', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
            MapEntry('Height & Complexion', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' • ' : ''}${biodata.complexion}'.trim()),
            MapEntry('Blood Group', biodata.bloodGroup),
            MapEntry('Marital Status', biodata.maritalStatus),
            MapEntry('Mother Tongue', biodata.motherTongue),
            MapEntry('Caste & Subcaste', '${biodata.caste}${biodata.subCaste.isNotEmpty ? ' (${biodata.subCaste})' : ''}'.trim()),
            MapEntry('Gotra / Devak', biodata.displayGotraDevak),
            MapEntry('Rashi / Nakshatra', biodata.displayRashiNakshatra),
            MapEntry('Manglik / Nadi', biodata.displayManglikNadi),
            if (biodata.displayGanKuldaivat.isNotEmpty)
              MapEntry('Gan / Kuldaivat', biodata.displayGanKuldaivat),
          ], primaryColor, softRose),

          const SizedBox(height: 8),

          _buildSection('Education & Career', [
            MapEntry('Education', biodata.highestEducation),
            MapEntry('Degree Details', biodata.educationDetails),
            MapEntry('Occupation', biodata.occupation),
            MapEntry('Company', biodata.companyName),
            MapEntry('Annual Income', biodata.annualIncome),
            MapEntry('Work Location', biodata.workLocation),
          ], primaryColor, softRose),

          const SizedBox(height: 8),

          _buildSection(
            'Family Details',
            [
              if (biodata.hasBrothers) MapEntry('Brothers', biodata.displayBrothers),
              if (biodata.hasSisters) MapEntry('Sisters', biodata.displaySisters),
              if (biodata.maternalUncleDetails.isNotEmpty)
                MapEntry('Mama / Uncle', biodata.displayMaternalUncle),
              if (biodata.hasFamilyType) MapEntry('Family Type', biodata.displayFamilyType),
              if (biodata.hasFamilyValues) MapEntry('Family Values', biodata.displayFamilyValues),
            ],
            primaryColor,
            softRose,
            topFullWidthItems: [
              MapEntry("Father's Name", biodata.displayFatherDetails),
              MapEntry("Mother's Name", biodata.displayMotherDetails),
            ],
          ),

          const SizedBox(height: 8),

          _buildSection('Contact Information', [
            MapEntry('Contact Person', biodata.contactPerson),
            MapEntry(biodata.primaryContactLabel, biodata.displayPrimaryContact),
            MapEntry(biodata.alternateContactLabel, biodata.displayAlternateContact),
            MapEntry('Email', biodata.email),
            MapEntry('Native Place', biodata.nativePlace),
          ], primaryColor, softRose, fullWidthItem: BiodataModel.isValuePresent(biodata.residentialAddress) ? MapEntry('Address', biodata.residentialAddress) : null),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<MapEntry<String, String>> items,
    Color primary,
    Color bg, {
    List<MapEntry<String, String>>? topFullWidthItems,
    MapEntry<String, String>? fullWidthItem,
  }) {
    final valid = items.where((e) => BiodataModel.isValuePresent(e.value)).toList();
    final validTop = topFullWidthItems?.where((e) => BiodataModel.isValuePresent(e.value)).toList() ?? [];

    if (valid.isEmpty && validTop.isEmpty && (fullWidthItem == null || !BiodataModel.isValuePresent(fullWidthItem.value))) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_florist, size: 14, color: primary),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.8, height: 10),
          if (validTop.isNotEmpty) ...[
            for (final item in validTop)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 95,
                      child: Text(
                        item.key,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF555555),
                        ),
                      ),
                    ),
                    const Text(': ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Expanded(
                      child: Text(
                        item.value,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 2),
          ],
          if (valid.isNotEmpty)
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: valid.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                final isSingleLast = (valid.length % 2 != 0) && (idx == valid.length - 1);
                final width = isSingleLast ? 508.0 : 248.0;

                return SizedBox(
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 95,
                        child: Text(
                          item.key,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF555555),
                          ),
                        ),
                      ),
                      const Text(': ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Expanded(
                        child: Text(
                          item.value,
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
                      color: const Color(0xFF555555),
                    ),
                  ),
                ),
                const Text(': ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                Expanded(
                  child: Text(
                    fullWidthItem.value,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
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
