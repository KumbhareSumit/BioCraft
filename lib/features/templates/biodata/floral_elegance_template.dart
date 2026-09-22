import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../biodata_creator/data/models/biodata_model.dart';

class FloralEleganceTemplate extends StatelessWidget {
  final BiodataModel biodata;

  const FloralEleganceTemplate({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const softRose = Color(0xFFFDE8EC);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.08),
            blurRadius: 16,
            spreadRadius: 2,
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
          if (biodata.occupation.isNotEmpty)
            Text(
              biodata.occupation,
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          const SizedBox(height: 16),

          _buildSection('Personal Information', [
            _row('Date of Birth', biodata.dateOfBirth),
            _row('Time & Place', '${biodata.timeOfBirth} ${biodata.placeOfBirth}'.trim()),
            _row('Height & Blood Group', '${biodata.height} | ${biodata.bloodGroup}'.trim()),
            _row('Marital Status', biodata.maritalStatus),
            _row('Caste & Subcaste', '${biodata.caste} ${biodata.subCaste.isNotEmpty ? '(${biodata.subCaste})' : ''}'.trim()),
            _row('Gotra & Rashi', '${biodata.gotra} | ${biodata.rashi}'.trim()),
            _row('Manglik', biodata.manglik),
          ], primaryColor, softRose),

          _buildSection('Education & Career', [
            _row('Education', biodata.highestEducation),
            _row('Details', biodata.educationDetails),
            _row('Designation', biodata.occupation),
            _row('Company', biodata.companyName),
            _row('Package / Income', biodata.annualIncome),
            _row('Location', biodata.workLocation),
          ], primaryColor, softRose),

          _buildSection('Family Details', [
            _row('Father', '${biodata.fatherName} (${biodata.fatherOccupation})'.trim()),
            _row('Mother', '${biodata.motherName} (${biodata.motherOccupation})'.trim()),
            _row('Brothers', biodata.brothersDetails.isNotEmpty ? biodata.brothersDetails : biodata.brothersCount),
            _row('Sisters', biodata.sistersDetails.isNotEmpty ? biodata.sistersDetails : biodata.sistersCount),
          ], primaryColor, softRose),

          _buildSection('Contact Information', [
            _row('Contact Person', biodata.contactPerson),
            _row('Phone Number', biodata.contactNumber),
            _row('Email', biodata.email),
            _row('Address', biodata.residentialAddress),
          ], primaryColor, softRose),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, Color primary, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary.withValues(alpha: 0.15)),
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
          const Divider(thickness: 0.8, height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    if (value.trim().isEmpty || value.trim() == '|' || value.trim() == '/') return const SizedBox.shrink();
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
                color: const Color(0xFF555555),
              ),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 11.5, color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 11.5,
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
