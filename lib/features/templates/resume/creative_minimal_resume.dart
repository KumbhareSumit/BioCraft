import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class CreativeMinimalResume extends StatelessWidget {
  final ResumeModel resume;

  const CreativeMinimalResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(resume.primaryColorValue);

    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: themeColor.withValues(alpha: 0.15),
                  child: Text(
                    resume.fullName.isNotEmpty ? resume.fullName[0].toUpperCase() : 'U',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resume.fullName.isNotEmpty ? resume.fullName : 'Your Full Name',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        resume.professionalTitle.isNotEmpty ? resume.professionalTitle : 'Designation / Field',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (resume.email.isNotEmpty)
                      Text(resume.email, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                    if (resume.phone.isNotEmpty)
                      Text(resume.phone, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B))),
                    if (resume.location.isNotEmpty)
                      Text(resume.location, style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF94A3B8))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Summary
          if (resume.summary.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: themeColor, width: 3)),
              ),
              child: Text(
                resume.summary,
                style: GoogleFonts.outfit(fontSize: 10.5, color: const Color(0xFF334155), height: 1.35),
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Experience
          if (resume.experiences.isNotEmpty) ...[
            _buildHeading('EXPERIENCE', themeColor),
            const SizedBox(height: 8),
            ...resume.experiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            exp.role,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            '${exp.startDate} - ${exp.isCurrent ? 'Present' : exp.endDate}',
                            style: GoogleFonts.outfit(fontSize: 9.5, fontWeight: FontWeight.bold, color: themeColor),
                          ),
                        ],
                      ),
                      Text(
                        '${exp.company} • ${exp.location}',
                        style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B)),
                      ),
                      if (exp.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          exp.description,
                          style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF334155), height: 1.3),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],

          // Skills Chips
          if (resume.skills.isNotEmpty) ...[
            _buildHeading('SKILLS & EXPERTISE', themeColor),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: resume.skills.map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: themeColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    s,
                    style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
          ],

          // Education & Projects Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (resume.educations.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeading('EDUCATION', themeColor),
                      const SizedBox(height: 6),
                      ...resume.educations.map((edu) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(edu.degree, style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold)),
                                Text(edu.institution, style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF64748B))),
                                Text('${edu.startYear} - ${edu.endYear}', style: GoogleFonts.outfit(fontSize: 9, color: const Color(0xFF94A3B8))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              if (resume.educations.isNotEmpty && resume.projects.isNotEmpty)
                const SizedBox(width: 14),
              if (resume.projects.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeading('FEATURED PROJECTS', themeColor),
                      const SizedBox(height: 6),
                      ...resume.projects.map((proj) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(proj.title, style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold)),
                                if (proj.technologies.isNotEmpty)
                                  Text(proj.technologies, style: GoogleFonts.outfit(fontSize: 9.5, color: themeColor)),
                                if (proj.description.isNotEmpty)
                                  Text(proj.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.outfit(fontSize: 9.5, color: const Color(0xFF475569))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeading(String title, Color color) {
    return Row(
      children: [
        Container(width: 4, height: 14, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
