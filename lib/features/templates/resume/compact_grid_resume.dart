import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class CompactGridResume extends StatelessWidget {
  final ResumeModel resume;

  const CompactGridResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(resume.primaryColorValue != 0xFF1E3A8A ? resume.primaryColorValue : 0xFF2563EB);
    const slateDark = Color(0xFF0F172A);
    const bgCard = Color(0xFFF8FAFC);
    const borderCard = Color(0xFFE2E8F0);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: bgCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderCard),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resume.fullName.isNotEmpty ? resume.fullName : 'Candidate Name',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: slateDark,
                        ),
                      ),
                      if (resume.professionalTitle.isNotEmpty)
                        Text(
                          resume.professionalTitle,
                          style: GoogleFonts.outfit(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: themeColor,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (resume.email.isNotEmpty)
                      _buildContactText(Icons.email_outlined, resume.email, themeColor),
                    if (resume.phone.isNotEmpty)
                      _buildContactText(Icons.phone_outlined, resume.phone, themeColor),
                    if (resume.location.isNotEmpty)
                      _buildContactText(Icons.location_on_outlined, resume.location, themeColor),
                    if (resume.github.isNotEmpty)
                      _buildContactText(Icons.code, resume.github, themeColor),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Summary
          if (resume.summary.isNotEmpty) ...[
            _buildGridSectionHeader('ABOUT ME', themeColor),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 10),
              child: Text(
                resume.summary,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  height: 1.4,
                  color: const Color(0xFF334155),
                ),
              ),
            ),
          ],

          // Experience Section
          if (resume.experiences.isNotEmpty) ...[
            _buildGridSectionHeader('WORK EXPERIENCE', themeColor),
            const SizedBox(height: 6),
            ...resume.experiences.map((exp) => _buildExperienceCard(exp, themeColor, bgCard, borderCard)),
            const SizedBox(height: 10),
          ],

          // Projects Section
          if (resume.projects.isNotEmpty) ...[
            _buildGridSectionHeader('FEATURED PROJECTS', themeColor),
            const SizedBox(height: 6),
            ...resume.projects.map((proj) => _buildProjectCard(proj, themeColor, bgCard, borderCard)),
            const SizedBox(height: 10),
          ],

          // Skills Section
          if (resume.skills.isNotEmpty) ...[
            _buildGridSectionHeader('TECHNICAL SKILLS', themeColor),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 5,
              children: resume.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: themeColor.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    skill,
                    style: GoogleFonts.outfit(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: themeColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],

          // Education Section
          if (resume.educations.isNotEmpty) ...[
            _buildGridSectionHeader('EDUCATION', themeColor),
            const SizedBox(height: 6),
            ...resume.educations.map((edu) => _buildEducationRow(edu, themeColor)),
            const SizedBox(height: 10),
          ],

          // Certifications & Languages
          if (resume.certifications.isNotEmpty || resume.languages.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (resume.certifications.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGridSectionHeader('CERTIFICATES', themeColor),
                        const SizedBox(height: 4),
                        ...resume.certifications.map((c) => Text('• $c', style: GoogleFonts.outfit(fontSize: 10.5, color: const Color(0xFF334155)))),
                      ],
                    ),
                  ),
                if (resume.certifications.isNotEmpty && resume.languages.isNotEmpty)
                  const SizedBox(width: 12),
                if (resume.languages.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGridSectionHeader('LANGUAGES', themeColor),
                        const SizedBox(height: 4),
                        Text(
                          resume.languages.join(' • '),
                          style: GoogleFonts.outfit(fontSize: 10.5, color: const Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactText(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.outfit(fontSize: 10.5, color: const Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildGridSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(ExperienceItem exp, Color themeColor, Color bg, Color border) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exp.role,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Text(
                  '${exp.startDate} - ${exp.isCurrent ? 'Present' : exp.endDate}',
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: themeColor,
                  ),
                ),
              ],
            ),
            if (exp.company.isNotEmpty || exp.location.isNotEmpty)
              Text(
                '${exp.company}${exp.location.isNotEmpty ? ' • ${exp.location}' : ''}',
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            if (exp.description.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(
                exp.description,
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  height: 1.3,
                  color: const Color(0xFF334155),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectItem proj, Color themeColor, Color bg, Color border) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    proj.title,
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                if (proj.link.isNotEmpty)
                  Text(
                    proj.link,
                    style: GoogleFonts.outfit(fontSize: 10, color: themeColor),
                  ),
              ],
            ),
            if (proj.technologies.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                proj.technologies,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: themeColor,
                ),
              ),
            ],
            if (proj.description.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                proj.description,
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  height: 1.25,
                  color: const Color(0xFF334155),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEducationRow(EducationItem edu, Color themeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${edu.degree} - ${edu.institution}',
              style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
            ),
          ),
          Text(
            '${edu.startYear}-${edu.endYear}',
            style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
