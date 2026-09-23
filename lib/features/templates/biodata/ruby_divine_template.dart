import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class RubyDivineTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const RubyDivineTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final rubyPrimary = Color(biodata.primaryColorValue);
    const goldAccent = Color(0xFFD4AF37);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;
    const paleRubyBg = Color(0xFFFEF2F2);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFB),
        border: Border.all(color: rubyPrimary, width: 3),
        boxShadow: [
          BoxShadow(
            color: rubyPrimary.withValues(alpha: 0.15),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
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
                                '॥ शुभ विवाह बायोडेटा ॥',
                                style: GoogleFonts.cinzel(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: rubyPrimary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Divider(color: goldAccent, thickness: 1)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: rubyPrimary,
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
                      borderColor: rubyPrimary,
                      innerBorderColor: goldAccent,
                    ),
                  ],
                ),
              )
            else ...[
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
              Text(
                biodata.fullName.isNotEmpty ? biodata.fullName : 'Candidate Name',
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: rubyPrimary,
                ),
              ),
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 14),

            // Section 1: Personal Details
            _buildSectionBanner('PERSONAL & HOROSCOPE DETAILS', rubyPrimary, goldAccent),
            _buildGrid([
              MapEntry('Date of Birth', biodata.dateOfBirth),
              MapEntry('Time of Birth', biodata.timeOfBirth),
              MapEntry('Place of Birth', biodata.placeOfBirth),
              MapEntry('Height / Complexion', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' • ' : ''}${biodata.complexion}'.trim()),
              MapEntry('Blood Group', biodata.bloodGroup),
              MapEntry('Marital Status', biodata.maritalStatus),
              MapEntry('Mother Tongue', biodata.motherTongue),
              MapEntry('Religion / Caste', '${biodata.religion}${biodata.caste.isNotEmpty ? ' - ${biodata.caste}' : ''}${biodata.subCaste.isNotEmpty ? ' (${biodata.subCaste})' : ''}'.trim()),
              MapEntry('Gotra / Devak', biodata.displayGotraDevak),
              MapEntry('Rashi / Nakshatra', biodata.displayRashiNakshatra),
              MapEntry('Manglik / Nadi', biodata.displayManglikNadi),
              if (biodata.displayGanKuldaivat.isNotEmpty)
                MapEntry('Gan / Kuldaivat', biodata.displayGanKuldaivat),
            ]),

            const SizedBox(height: 8),

            // Section 2: Education & Career
            _buildSectionBanner('EDUCATION & OCCUPATION', rubyPrimary, goldAccent),
            _buildGrid([
              MapEntry('Education', biodata.highestEducation),
              MapEntry('Degree Details', biodata.educationDetails),
              MapEntry('Occupation', biodata.occupation),
              MapEntry('Company / Firm', biodata.companyName),
              MapEntry('Annual Income', biodata.annualIncome),
              MapEntry('Job Location', biodata.workLocation),
            ]),

            const SizedBox(height: 8),

            // Section 3: Family Details
            _buildSectionBanner('FAMILY BACKGROUND', rubyPrimary, goldAccent),
            _buildGrid([
              MapEntry("Father's Name", '${biodata.fatherName}${biodata.fatherOccupation.isNotEmpty ? ' (${biodata.fatherOccupation})' : ''}'.trim()),
              MapEntry("Mother's Name", '${biodata.motherName}${biodata.motherOccupation.isNotEmpty ? ' (${biodata.motherOccupation})' : ''}'.trim()),
              if (biodata.hasBrothers) MapEntry('Brothers', biodata.displayBrothers),
              if (biodata.hasSisters) MapEntry('Sisters', biodata.displaySisters),
              if (biodata.hasFamilyType) MapEntry('Family Type', biodata.displayFamilyType),
              if (biodata.hasFamilyValues) MapEntry('Family Values', biodata.displayFamilyValues),
            ]),
            if (biodata.maternalUncleDetails.isNotEmpty)
              _buildFullWidthRow('Maternal Uncle (Mama)', biodata.maternalUncleDetails),

            const SizedBox(height: 8),

            // Section 4: Contact & Address
            _buildSectionBanner('CONTACT & RESIDENCE', rubyPrimary, goldAccent),
            _buildGrid([
              MapEntry('Contact Person', biodata.contactPerson),
              MapEntry(biodata.primaryContactLabel, biodata.displayPrimaryContact),
              MapEntry(biodata.alternateContactLabel, biodata.displayAlternateContact),
              MapEntry('Email ID', biodata.email),
              MapEntry('Native Place', biodata.nativePlace),
            ]),
            if (biodata.residentialAddress.isNotEmpty)
              _buildFullWidthRow('Address', biodata.residentialAddress),

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

  Widget _buildSectionBanner(String title, Color primary, Color gold) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
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
