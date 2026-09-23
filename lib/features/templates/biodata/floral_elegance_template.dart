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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '~ Marriage Biodata ~',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            color: primaryColor.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 24,
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
              '~ Marriage Biodata ~',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: primaryColor.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
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
            MapEntry('Gotra & Rashi', '${biodata.gotra}${biodata.rashi.isNotEmpty ? ' / ${biodata.rashi}' : ''}'.trim()),
            MapEntry('Manglik Status', biodata.manglik),
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

          _buildSection('Family Details', [
            MapEntry("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
            MapEntry("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
            MapEntry('Brothers', biodata.displayBrothers),
            MapEntry('Sisters', biodata.displaySisters),
            MapEntry('Family Setup', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
          ], primaryColor, softRose, fullWidthItem: biodata.maternalUncleDetails.isNotEmpty ? MapEntry('Mama / Uncle', biodata.maternalUncleDetails) : null),

          const SizedBox(height: 8),

          _buildSection('Contact Information', [
            MapEntry('Contact Person', biodata.contactPerson),
            MapEntry('Phone Number', biodata.displayPrimaryContact),
            MapEntry('Alternate Phone', biodata.displayAlternateContact),
            MapEntry('Email', biodata.email),
            MapEntry('Native Place', biodata.nativePlace),
          ], primaryColor, softRose, fullWidthItem: biodata.residentialAddress.isNotEmpty ? MapEntry('Address', biodata.residentialAddress) : null),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<MapEntry<String, String>> items,
    Color primary,
    Color bg, {
    MapEntry<String, String>? fullWidthItem,
  }) {
    final valid = items.where((e) {
      final v = e.value.trim();
      return v.isNotEmpty && v != '|' && v != '/';
    }).toList();

    if (valid.isEmpty && (fullWidthItem == null || fullWidthItem.value.trim().isEmpty)) {
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
          Wrap(
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
                          color: const Color(0xFF555555),
                        ),
                      ),
                    ),
                    const Text(': ', style: TextStyle(fontSize: 11, color: Colors.grey)),
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
