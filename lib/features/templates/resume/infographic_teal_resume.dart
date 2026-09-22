import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class InfographicTealResume extends StatelessWidget {
  final ResumeModel resume;

  const InfographicTealResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(resume.primaryColorValue != 0xFF1E3A8A ? resume.primaryColorValue : 0xFF0D9488);
    const darkSlate = Color(0xFF0F172A);
    const softTealBg = Color(0xFFF0FDFA);

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, themeColor.withValues(alpha: 0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.fullName.isNotEmpty ? resume.fullName.toUpperCase() : 'CANDIDATE NAME',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                if (resume.professionalTitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    resume.professionalTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFCCFBF1),
                    ),
                  ),
                ],
                const SizedBox(height: 12),

                // Contact wrap
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    if (resume.email.isNotEmpty)
                      _buildHeaderContactItem(Icons.email_outlined, resume.email),
                    if (resume.phone.isNotEmpty)
                      _buildHeaderContactItem(Icons.phone_outlined, resume.phone),
                    if (resume.location.isNotEmpty)
                      _buildHeaderContactItem(Icons.location_on_outlined, resume.location),
                    if (resume.linkedin.isNotEmpty)
                      _buildHeaderContactItem(Icons.link_outlined, resume.linkedin),
                    if (resume.github.isNotEmpty)
                      _buildHeaderContactItem(Icons.code_outlined, resume.github),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary
                if (resume.summary.isNotEmpty) ...[
                  _buildSectionHeading('PROFESSIONAL SUMMARY', themeColor, Icons.person_outline),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 14),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: softTealBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: themeColor.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        resume.summary,
                        style: GoogleFonts.outfit(
                          fontSize: 11.5,
                          height: 1.45,
                          color: darkSlate,
                        ),
                      ),
                    ),
                  ),
                ],

                // Experience
                if (resume.experiences.isNotEmpty) ...[
                  _buildSectionHeading('WORK EXPERIENCE', themeColor, Icons.work_outline),
                  const SizedBox(height: 8),
                  ...resume.experiences.map((exp) => _buildExperienceItem(exp, themeColor)),
                  const SizedBox(height: 10),
                ],

                // Projects
                if (resume.projects.isNotEmpty) ...[
                  _buildSectionHeading('KEY PROJECTS', themeColor, Icons.rocket_launch_outlined),
                  const SizedBox(height: 8),
                  ...resume.projects.map((proj) => _buildProjectItem(proj, themeColor)),
                  const SizedBox(height: 10),
                ],

                // Skills Badges
                if (resume.skills.isNotEmpty) ...[
                  _buildSectionHeading('SKILLS & COMPETENCIES', themeColor, Icons.verified_outlined),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: resume.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: softTealBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: themeColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          skill,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: themeColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                ],

                // Education
                if (resume.educations.isNotEmpty) ...[
                  _buildSectionHeading('EDUCATION', themeColor, Icons.school_outlined),
                  const SizedBox(height: 8),
                  ...resume.educations.map((edu) => _buildEducationItem(edu, themeColor)),
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
                              _buildSectionHeading('CERTIFICATIONS', themeColor, Icons.military_tech_outlined),
                              const SizedBox(height: 6),
                              ...resume.certifications.map((c) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_circle_outline, size: 12, color: themeColor),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            c,
                                            style: GoogleFonts.outfit(fontSize: 11, color: darkSlate),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      if (resume.certifications.isNotEmpty && resume.languages.isNotEmpty)
                        const SizedBox(width: 14),
                      if (resume.languages.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeading('LANGUAGES', themeColor, Icons.language_outlined),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: resume.languages.map((l) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        l,
                                        style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.w500),
                                      ),
                                    )).toList(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.outfit(fontSize: 11, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSectionHeading(String title, Color color, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Divider(color: color.withValues(alpha: 0.25), thickness: 1),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(ExperienceItem exp, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  exp.role,
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${exp.startDate} - ${exp.isCurrent ? 'Present' : exp.endDate}',
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          if (exp.company.isNotEmpty || exp.location.isNotEmpty)
            Text(
              '${exp.company}${exp.location.isNotEmpty ? ', ${exp.location}' : ''}',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          if (exp.description.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              exp.description,
              style: GoogleFonts.outfit(
                fontSize: 11,
                height: 1.35,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectItem(ProjectItem proj, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                if (proj.link.isNotEmpty)
                  Text(
                    proj.link,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
            if (proj.technologies.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                'Tech: ${proj.technologies}',
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
            if (proj.description.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(
                proj.description,
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  height: 1.3,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEducationItem(EducationItem edu, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.degree,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  '${edu.institution}${edu.location.isNotEmpty ? ', ${edu.location}' : ''}',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${edu.startYear} - ${edu.endYear}',
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              if (edu.score.isNotEmpty)
                Text(
                  edu.score,
                  style: GoogleFonts.outfit(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
