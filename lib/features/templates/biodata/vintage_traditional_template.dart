import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class VintageTraditionalTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const VintageTraditionalTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const vintageGold = Color(0xFFC5A059);
    const parchment = Color(0xFFFAF6EE);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: parchment,
        border: Border.all(color: vintageGold, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 12,
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
            style: GoogleFonts.cinzelDecorative(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),

          _buildSection('व्यक्तिगत विवरण (Personal Details)', [
            _row('जन्म तिथि (DOB)', biodata.dateOfBirth),
            _row('जन्म समय व स्थान', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
            _row('ऊंचाई व वर्ण', '${biodata.height} ${biodata.complexion}'.trim()),
            _row('जाति व उपजाति', '${biodata.caste} ${biodata.subCaste}'.trim()),
            _row('गोत्र व राशि', '${biodata.gotra} / ${biodata.rashi}'.trim()),
            _row('मांगलिक', biodata.manglik),
          ], vintageGold, primaryColor),

          _buildSection('शिक्षा एवं कार्य (Education & Career)', [
            _row('उच्चतम शिक्षा', biodata.highestEducation),
            _row('व्यवसाय / पद', biodata.occupation),
            _row('कंपनी / संस्थान', biodata.companyName),
            _row('वार्षिक आय', biodata.annualIncome),
          ], vintageGold, primaryColor),

          _buildSection('पारिवारिक विवरण (Family Details)', [
            _row('पिताजी का नाम', '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
            _row('माताजी का नाम', '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
            _row('भाई / बहन', 'भाई: ${biodata.brothersCount}, बहन: ${biodata.sistersCount}'),
            _row('मामा / ननिहाल', biodata.maternalUncleDetails),
          ], vintageGold, primaryColor),

          _buildSection('सम्पर्क सूत्र (Contact)', [
            _row('सम्पर्क व्यक्ति', biodata.contactPerson),
            _row('मोबाइल नंबर', biodata.contactNumber),
            _row('निवास स्थान', biodata.residentialAddress),
          ], vintageGold, primaryColor),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, Color borderCol, Color titleCol) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: borderCol.withValues(alpha: 0.5)),
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
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
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
