import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class ModernTechResume extends StatelessWidget {
  final ResumeModel resume;

  const ModernTechResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(resume.primaryColorValue);

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            color: themeColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.fullName.isNotEmpty ? resume.fullName : 'Your Full Name',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  resume.professionalTitle.isNotEmpty ? resume.professionalTitle : 'Professional Title',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    if (resume.email.isNotEmpty)
                      _buildHeaderContact(Icons.email_outlined, resume.email),
                    if (resume.phone.isNotEmpty)
                      _buildHeaderContact(Icons.phone_outlined, resume.phone),
                    if (resume.location.isNotEmpty)
                      _buildHeaderContact(Icons.location_on_outlined, resume.location),
                    if (resume.linkedin.isNotEmpty)
                      _buildHeaderContact(Icons.link, resume.linkedin),
                    if (resume.github.isNotEmpty)
                      _buildHeaderContact(Icons.code, resume.github),
                  ],
                ),
              ],
            ),
          ),

          // Main 2-Column Content Body
          Padding(
            padding: const EdgeInsets.all(18),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column (Skills, Education, Languages, Certifications) - 38%
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Skills
                        if (resume.skills.isNotEmpty) ...[
                          _buildSectionHeader('SKILLS', themeColor),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: resume.skills.map((skill) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: themeColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  skill,
                                  style: GoogleFonts.outfit(
                                    fontSize: 9.5,
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
                          _buildSectionHeader('EDUCATION', themeColor),
                          const SizedBox(height: 8),
                          ...resume.educations.map((edu) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    edu.degree,
                                    style: GoogleFonts.outfit(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  Text(
                                    edu.institution,
                                    style: GoogleFonts.outfit(
                                      fontSize: 9.5,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    spacing: 6,
                                    children: [
                                      Text(
                                        '${edu.startYear} - ${edu.endYear}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 9,
                                          color: const Color(0xFF94A3B8),
                                        ),
                                      ),
                                      if (edu.score.isNotEmpty)
                                        Text(
                                          edu.score,
                                          style: GoogleFonts.outfit(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            color: themeColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                        ],

                        // Certifications
                        if (resume.certifications.isNotEmpty) ...[
                          _buildSectionHeader('CERTIFICATIONS', themeColor),
                          const SizedBox(height: 8),
                          ...resume.certifications.map((cert) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(color: themeColor, fontWeight: FontWeight.bold, fontSize: 10)),
                                  Expanded(
                                    child: Text(
                                      cert,
                                      style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF334155)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                        ],

                        // Languages
                        if (resume.languages.isNotEmpty) ...[
                          _buildSectionHeader('LANGUAGES', themeColor),
                          const SizedBox(height: 6),
                          Text(
                            resume.languages.join(' • '),
                            style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF475569)),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),
                  Container(width: 1, color: const Color(0xFFE2E8F0)),
                  const SizedBox(width: 14),

                  // Right Column (Summary, Experience, Projects) - 62%
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary
                        if (resume.summary.isNotEmpty) ...[
                          _buildSectionHeader('PROFESSIONAL SUMMARY', themeColor),
                          const SizedBox(height: 6),
                          Text(
                            resume.summary,
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: const Color(0xFF334155),
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],

                        // Experience
                        if (resume.experiences.isNotEmpty) ...[
                          _buildSectionHeader('WORK EXPERIENCE', themeColor),
                          const SizedBox(height: 8),
                          ...resume.experiences.map((exp) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          exp.role,
                                          style: GoogleFonts.outfit(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${exp.startDate} - ${exp.isCurrent ? 'Present' : exp.endDate}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color: themeColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${exp.company}${exp.location.isNotEmpty ? ' • ${exp.location}' : ''}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                  if (exp.description.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      exp.description,
                                      style: GoogleFonts.outfit(
                                        fontSize: 9.5,
                                        color: const Color(0xFF334155),
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 10),
                        ],

                        // Projects
                        if (resume.projects.isNotEmpty) ...[
                          _buildSectionHeader('KEY PROJECTS', themeColor),
                          const SizedBox(height: 8),
                          ...resume.projects.map((proj) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          proj.title,
                                          style: GoogleFonts.outfit(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ),
                                      if (proj.link.isNotEmpty) ...[
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            proj.link,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.outfit(
                                              fontSize: 8.5,
                                              color: themeColor,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  if (proj.technologies.isNotEmpty)
                                    Text(
                                      'Tech: ${proj.technologies}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 9,
                                        fontStyle: FontStyle.italic,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  if (proj.description.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      proj.description,
                                      style: GoogleFonts.outfit(
                                        fontSize: 9.5,
                                        color: const Color(0xFF334155),
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Container(height: 1.5, width: 24, color: color),
      ],
    );
  }

  Widget _buildHeaderContact(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.outfit(fontSize: 10, color: Colors.white),
        ),
      ],
    );
  }
}
