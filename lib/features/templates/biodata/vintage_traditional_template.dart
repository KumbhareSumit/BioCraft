import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class VintageTraditionalTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const VintageTraditionalTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const vintageGold = Color(0xFFB45309);
    final hasPhoto = biodata.profileImagePath != null && biodata.profileImagePath!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        border: Border.all(color: vintageGold, width: 2.5),
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
        children: [
          // Om / Sacred Symbol
          if (biodata.religionHeading.isNotEmpty)
            Text(
              biodata.religionHeading,
              style: GoogleFonts.cinzelDecorative(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryColor,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '॥ विवाह परिचय पत्र ॥',
                          style: GoogleFonts.cinzelDecorative(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: vintageGold,
                          ),
                        ),
                        const Divider(color: vintageGold, thickness: 1.5, height: 12),
                        Text(
                          biodata.fullName.isNotEmpty ? biodata.fullName : 'वर / वधू का नाम',
                          style: GoogleFonts.cinzelDecorative(
                            fontSize: 20,
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
                    borderColor: vintageGold,
                    innerBorderColor: primaryColor.withValues(alpha: 0.6),
                  ),
                ],
              ),
            )
          else ...[
            Text(
              '॥ विवाह परिचय पत्र ॥',
              style: GoogleFonts.cinzelDecorative(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: vintageGold,
              ),
            ),
            const Divider(color: vintageGold, thickness: 1.5, height: 16),
            Text(
              biodata.fullName.isNotEmpty ? biodata.fullName : 'वर / वधू का नाम',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzelDecorative(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
          ],

          _buildSection('व्यक्तिगत विवरण (Personal Details)', [
            MapEntry('जन्म तिथि (DOB)', biodata.dateOfBirth),
            MapEntry('जन्म समय व स्थान', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
            MapEntry('ऊंचाई व वर्ण', '${biodata.height}${biodata.height.isNotEmpty && biodata.complexion.isNotEmpty ? ' • ' : ''}${biodata.complexion}'.trim()),
            MapEntry('जाति व उपजाति', '${biodata.caste}${biodata.subCaste.isNotEmpty ? ' (${biodata.subCaste})' : ''}'.trim()),
            MapEntry('गोत्र / देवक', biodata.displayGotraDevak),
            MapEntry('राशि / नक्षत्र', biodata.displayRashiNakshatra),
            MapEntry('मांगलिक / नाडी', biodata.displayManglikNadi),
            if (biodata.displayGanKuldaivat.isNotEmpty)
              MapEntry('गण / कुलदैवत', biodata.displayGanKuldaivat),
          ], vintageGold, primaryColor),

          const SizedBox(height: 8),

          _buildSection('शिक्षा एवं कार्य (Education & Career)', [
            MapEntry('उच्चतम शिक्षा', biodata.highestEducation),
            MapEntry('व्यवसाय / पद', biodata.occupation),
            MapEntry('कंपनी / संस्थान', biodata.companyName),
            MapEntry('वार्षिक आय', biodata.annualIncome),
            MapEntry('कार्य स्थान', biodata.workLocation),
          ], vintageGold, primaryColor),

          const SizedBox(height: 8),

          _buildSection('पारिवारिक विवरण (Family Details)', [
            if (BiodataModel.isValuePresent(biodata.displayFatherDetails))
              MapEntry('पिताजी का नाम', biodata.displayFatherDetails),
            if (BiodataModel.isValuePresent(biodata.displayMotherDetails))
              MapEntry('माताजी का नाम', biodata.displayMotherDetails),
            if (biodata.hasBrothers) MapEntry('भाई', biodata.displayBrothers),
            if (biodata.hasSisters) MapEntry('बहन', biodata.displaySisters),
            if (biodata.hasFamilyType) MapEntry('परिवार का प्रकार', biodata.displayFamilyType),
            if (biodata.hasFamilyValues) MapEntry('पारिवारिक संस्कार', biodata.displayFamilyValues),
            if (biodata.maternalUncleDetails.isNotEmpty)
              MapEntry('मामा / ननिहाल', biodata.displayMaternalUncle),
          ], vintageGold, primaryColor),

          const SizedBox(height: 8),

          _buildSection('सम्पर्क सूत्र (Contact)', [
            MapEntry('सम्पर्क व्यक्ति', biodata.contactPerson),
            MapEntry(biodata.primaryContactLabelHindi, biodata.displayPrimaryContact),
            MapEntry(biodata.alternateContactLabelHindi, biodata.displayAlternateContact),
            MapEntry('मूल निवास', biodata.nativePlace),
          ], vintageGold, primaryColor, fullWidthItem: BiodataModel.isValuePresent(biodata.residentialAddress) ? MapEntry('वर्तमान पता', biodata.residentialAddress) : null),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<MapEntry<String, String>> items,
    Color borderCol,
    Color titleCol, {
    MapEntry<String, String>? fullWidthItem,
  }) {
    final valid = items.where((e) => BiodataModel.isValuePresent(e.value)).toList();
    if (valid.isEmpty && (fullWidthItem == null || !BiodataModel.isValuePresent(fullWidthItem.value))) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: borderCol.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: titleCol,
              ),
            ),
          ),
          const Divider(height: 8, thickness: 0.5),
          Wrap(
            spacing: 12,
            runSpacing: 3,
            children: valid.asMap().entries.map((entry) {
              final idx = entry.key;
              final e = entry.value;
              final isSingleLast = (valid.length % 2 != 0) && (idx == valid.length - 1);
              final width = isSingleLast ? 508.0 : 248.0;

              return SizedBox(
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        e.key,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4E3629),
                        ),
                      ),
                    ),
                    const Text(' : ', style: TextStyle(fontSize: 11, color: Colors.brown)),
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
          if (fullWidthItem != null && BiodataModel.isValuePresent(fullWidthItem.value)) ...[
            const SizedBox(height: 3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    fullWidthItem.key,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E3629),
                    ),
                  ),
                ),
                const Text(' : ', style: TextStyle(fontSize: 11, color: Colors.brown)),
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
