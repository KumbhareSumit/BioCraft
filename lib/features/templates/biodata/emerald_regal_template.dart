import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class EmeraldRegalTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const EmeraldRegalTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final emeraldPrimary = Color(biodata.primaryColorValue);
    const goldAccent = Color(0xFFD4AF37);
    const softEmerald = Color(0xFFECFDF5);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFD),
        border: Border.all(color: emeraldPrimary, width: 3),
        boxShadow: [
          BoxShadow(
            color: emeraldPrimary.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: emeraldPrimary,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: goldAccent),
                            ),
                            child: Text(
                              '✦ MATRIMONIAL BIODATA ✦',
                              style: GoogleFonts.cinzel(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: goldAccent,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: emeraldPrimary,
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
                      borderColor: emeraldPrimary,
                      innerBorderColor: goldAccent,
                    ),
                  ],
                ),
              )
            else ...[
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
              Text(
                biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: emeraldPrimary,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Section 1: Personal Details
            _buildSectionHeader('PERSONAL PROFILE', emeraldPrimary, goldAccent),
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
              MapEntry('Nakshatra / Manglik', '${biodata.nakshatra}${biodata.nakshatra.isNotEmpty && biodata.manglik.isNotEmpty ? ' • ' : ''}${biodata.manglik.isNotEmpty ? 'Manglik: ${biodata.manglik}' : ''}'.trim()),
            ]),

            const SizedBox(height: 8),

            // Section 2: Education & Career
            _buildSectionHeader('EDUCATION & PROFESSION', emeraldPrimary, goldAccent),
            _buildGrid([
              MapEntry('Education', biodata.highestEducation),
              MapEntry('Degree / Details', biodata.educationDetails),
              MapEntry('Occupation', biodata.occupation),
              MapEntry('Organization', biodata.companyName),
              MapEntry('Annual Income', biodata.annualIncome),
              MapEntry('Work Location', biodata.workLocation),
            ]),

            const SizedBox(height: 8),

            // Section 3: Family Details
            _buildSectionHeader('FAMILY BACKGROUND', emeraldPrimary, goldAccent),
            _buildGrid([
              MapEntry("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
              MapEntry("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
              MapEntry('Brothers', biodata.displayBrothers),
              MapEntry('Sisters', biodata.displaySisters),
              MapEntry('Family Setup', '${biodata.familyType} Family, ${biodata.familyValues} Values'),
            ]),
            if (biodata.maternalUncleDetails.isNotEmpty)
              _buildFullWidthRow('Maternal Uncle (Mama)', biodata.maternalUncleDetails),

            const SizedBox(height: 8),

            // Section 4: Contact & Location
            _buildSectionHeader('CONTACT & CORRESPONDENCE', emeraldPrimary, goldAccent),
            _buildGrid([
              MapEntry('Contact Person', biodata.contactPerson),
              MapEntry('Primary Phone', biodata.displayPrimaryContact),
              MapEntry('Alternate Phone', biodata.displayAlternateContact),
              MapEntry('Email', biodata.email),
              MapEntry('Native Place', biodata.nativePlace),
            ]),
            if (biodata.residentialAddress.isNotEmpty)
              _buildFullWidthRow('Residential Address', biodata.residentialAddress),

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
                      fontSize: 11,
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 10),
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
