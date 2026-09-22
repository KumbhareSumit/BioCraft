import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class ExecutiveCleanResume extends StatelessWidget {
  final ResumeModel resume;

  const ExecutiveCleanResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(resume.primaryColorValue);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Centered Executive Header
          Center(
            child: Column(
              children: [
                Text(
                  resume.fullName.isNotEmpty ? resume.fullName.toUpperCase() : 'YOUR FULL NAME',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                if (resume.professionalTitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    resume.professionalTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: themeColor,
                      letterSpacing: 1,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    if (resume.email.isNotEmpty)
                      Text(resume.email, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                    if (resume.phone.isNotEmpty)
                      Text('•  ${resume.phone}', style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                    if (resume.location.isNotEmpty)
                      Text('•  ${resume.location}', style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                    if (resume.linkedin.isNotEmpty)
                      Text('•  ${resume.linkedin}', style: GoogleFonts.outfit(fontSize: 10, color: themeColor)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: themeColor, thickness: 1.5),
          const SizedBox(height: 10),

          // Executive Summary
          if (resume.summary.isNotEmpty) ...[
            _buildSectionHeading('EXECUTIVE SUMMARY', themeColor),
            const SizedBox(height: 4),
            Text(
              resume.summary,
              style: GoogleFonts.outfit(
                fontSize: 10.5,
                color: const Color(0xFF334155),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Professional Experience
          if (resume.experiences.isNotEmpty) ...[
            _buildSectionHeading('PROFESSIONAL EXPERIENCE', themeColor),
            const SizedBox(height: 6),
            ...resume.experiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          '${exp.startDate} – ${exp.isCurrent ? 'Present' : exp.endDate}',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${exp.company}${exp.location.isNotEmpty ? ', ${exp.location}' : ''}',
                      style: GoogleFonts.outfit(
                        fontSize: 10.5,
                        fontStyle: FontStyle.italic,
                        color: themeColor,
                      ),
                    ),
                    if (exp.description.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        exp.description,
                        style: GoogleFonts.outfit(
                          fontSize: 10,
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

          // Education
          if (resume.educations.isNotEmpty) ...[
            _buildSectionHeading('EDUCATION', themeColor),
            const SizedBox(height: 6),
            ...resume.educations.map((edu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edu.degree,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            '${edu.institution}${edu.location.isNotEmpty ? ', ${edu.location}' : ''}',
                            style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${edu.startYear} – ${edu.endYear}',
                          style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF64748B)),
                        ),
                        if (edu.score.isNotEmpty)
                          Text(
                            edu.score,
                            style: GoogleFonts.outfit(fontSize: 9.5, fontWeight: FontWeight.w600, color: themeColor),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 10),
          ],

          // Core Competencies & Skills
          if (resume.skills.isNotEmpty) ...[
            _buildSectionHeading('CORE COMPETENCIES & SKILLS', themeColor),
            const SizedBox(height: 6),
            Text(
              resume.skills.join('  •  '),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
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
                        _buildSectionHeading('CERTIFICATIONS', themeColor),
                        const SizedBox(height: 4),
                        ...resume.certifications.map((c) => Text('• $c', style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF475569)))),
                      ],
                    ),
                  ),
                if (resume.languages.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeading('LANGUAGES', themeColor),
                        const SizedBox(height: 4),
                        Text(resume.languages.join(', '), style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF475569))),
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

  Widget _buildSectionHeading(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cinzel(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Container(height: 1, width: double.infinity, color: const Color(0xFFCBD5E1)),
      ],
    );
  }
}
