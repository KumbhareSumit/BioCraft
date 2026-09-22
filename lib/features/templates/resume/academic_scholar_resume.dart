import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resume_creator/data/models/resume_model.dart';

class AcademicScholarResume extends StatelessWidget {
  final ResumeModel resume;

  const AcademicScholarResume({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E293B);
    const accentColor = Color(0xFF334155);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Candidate Name
          Text(
            resume.fullName.isNotEmpty ? resume.fullName : 'Candidate Name',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              letterSpacing: 0.5,
            ),
          ),
          if (resume.professionalTitle.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              resume.professionalTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: accentColor,
              ),
            ),
          ],
          const SizedBox(height: 8),

          // Contact Details Centered Wrap
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              if (resume.email.isNotEmpty)
                Text(resume.email, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF475569))),
              if (resume.email.isNotEmpty && resume.phone.isNotEmpty)
                const Text('•', style: TextStyle(fontSize: 11, color: Colors.grey)),
              if (resume.phone.isNotEmpty)
                Text(resume.phone, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF475569))),
              if (resume.location.isNotEmpty) ...[
                const Text('•', style: TextStyle(fontSize: 11, color: Colors.grey)),
                Text(resume.location, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF475569))),
              ],
              if (resume.linkedin.isNotEmpty) ...[
                const Text('•', style: TextStyle(fontSize: 11, color: Colors.grey)),
                Text(resume.linkedin, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF2563EB))),
              ],
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: primaryColor, thickness: 1.2),
          const SizedBox(height: 10),

          // Body Sections
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary / Research Interest
                if (resume.summary.isNotEmpty) ...[
                  _buildSectionHeader('EXECUTIVE & RESEARCH SUMMARY'),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      resume.summary,
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        height: 1.45,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],

                // Education (Prioritized for Academic CVs)
                if (resume.educations.isNotEmpty) ...[
                  _buildSectionHeader('EDUCATION & ACADEMIC CREDENTIALS'),
                  const SizedBox(height: 6),
                  ...resume.educations.map((edu) => _buildAcademicEducation(edu)),
                  const SizedBox(height: 10),
                ],

                // Experience / Research Appointments
                if (resume.experiences.isNotEmpty) ...[
                  _buildSectionHeader('EXPERIENCE & APPOINTMENTS'),
                  const SizedBox(height: 6),
                  ...resume.experiences.map((exp) => _buildAcademicExperience(exp)),
                  const SizedBox(height: 10),
                ],

                // Projects / Research Works
                if (resume.projects.isNotEmpty) ...[
                  _buildSectionHeader('KEY PROJECTS & PUBLICATIONS'),
                  const SizedBox(height: 6),
                  ...resume.projects.map((proj) => _buildAcademicProject(proj)),
                  const SizedBox(height: 10),
                ],

                // Areas of Expertise & Skills
                if (resume.skills.isNotEmpty) ...[
                  _buildSectionHeader('AREAS OF EXPERTISE & SKILLS'),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: Text(
                      resume.skills.join('  •  '),
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
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
                              _buildSectionHeader('HONORS & CERTIFICATIONS'),
                              const SizedBox(height: 4),
                              ...resume.certifications.map((c) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text('• $c', style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF334155))),
                                  )),
                            ],
                          ),
                        ),
                      if (resume.certifications.isNotEmpty && resume.languages.isNotEmpty)
                        const SizedBox(width: 16),
                      if (resume.languages.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader('LANGUAGES'),
                              const SizedBox(height: 4),
                              Text(
                                resume.languages.join(', '),
                                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF334155)),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          const Divider(color: Color(0xFF94A3B8), thickness: 0.8, height: 6),
        ],
      ),
    );
  }

  Widget _buildAcademicEducation(EducationItem edu) {
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
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF475569),
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
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              if (edu.score.isNotEmpty)
                Text(
                  edu.score,
                  style: GoogleFonts.outfit(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF475569),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicExperience(ExperienceItem exp) {
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
                    fontSize: 12,
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
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          if (exp.company.isNotEmpty || exp.location.isNotEmpty)
            Text(
              '${exp.company}${exp.location.isNotEmpty ? ', ${exp.location}' : ''}',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF475569),
              ),
            ),
          if (exp.description.isNotEmpty) ...[
            const SizedBox(height: 2),
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

  Widget _buildAcademicProject(ProjectItem proj) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
                  style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF2563EB)),
                ),
            ],
          ),
          if (proj.technologies.isNotEmpty)
            Text(
              'Keywords: ${proj.technologies}',
              style: GoogleFonts.outfit(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          if (proj.description.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              proj.description,
              style: GoogleFonts.outfit(
                fontSize: 10.5,
                height: 1.3,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
