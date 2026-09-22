import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/models/resume_model.dart';
import '../logic/resume_provider.dart';

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  late TextEditingController _fullNameController;
  late TextEditingController _profTitleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _linkedinController;
  late TextEditingController _githubController;
  late TextEditingController _portfolioController;
  late TextEditingController _summaryController;
  late TextEditingController _skillsInputController;
  late TextEditingController _certsInputController;
  late TextEditingController _langsInputController;

  List<ExperienceItem> _experiences = [];
  List<EducationItem> _educations = [];
  List<ProjectItem> _projects = [];
  List<String> _skills = [];
  List<String> _certifications = [];
  List<String> _languages = [];

  String? _loadedResumeId;

  @override
  void initState() {
    super.initState();
    final res = context.read<ResumeProvider>().currentResume;
    _loadedResumeId = res.id;
    _initControllers(res);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final res = context.watch<ResumeProvider>().currentResume;
    if (_loadedResumeId != res.id) {
      _loadedResumeId = res.id;
      _populateControllers(res);
    }
  }

  void _initControllers(ResumeModel res) {
    _fullNameController = TextEditingController();
    _profTitleController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _locationController = TextEditingController();
    _linkedinController = TextEditingController();
    _githubController = TextEditingController();
    _portfolioController = TextEditingController();
    _summaryController = TextEditingController();
    _skillsInputController = TextEditingController();
    _certsInputController = TextEditingController();
    _langsInputController = TextEditingController();

    _populateControllers(res);
  }

  void _populateControllers(ResumeModel res) {
    _fullNameController.text = res.fullName;
    _profTitleController.text = res.professionalTitle;
    _emailController.text = res.email;
    _phoneController.text = res.phone;
    _locationController.text = res.location;
    _linkedinController.text = res.linkedin;
    _githubController.text = res.github;
    _portfolioController.text = res.portfolio;
    _summaryController.text = res.summary;

    _experiences = List.from(res.experiences);
    _educations = List.from(res.educations);
    _projects = List.from(res.projects);
    _skills = List.from(res.skills);
    _certifications = List.from(res.certifications);
    _languages = List.from(res.languages);

    _skillsInputController.text = _skills.join(', ');
    _certsInputController.text = _certifications.join(', ');
    _langsInputController.text = _languages.join(', ');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _profTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _portfolioController.dispose();
    _summaryController.dispose();
    _skillsInputController.dispose();
    _certsInputController.dispose();
    _langsInputController.dispose();
    super.dispose();
  }

  void _syncToProvider() {
    final provider = context.read<ResumeProvider>();
    final current = provider.currentResume;

    // Parse comma-separated skills/certs/langs
    final parsedSkills = _skillsInputController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final parsedCerts = _certsInputController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final parsedLangs = _langsInputController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    provider.updateResume(
      current.copyWith(
        fullName: _fullNameController.text.trim(),
        professionalTitle: _profTitleController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        location: _locationController.text.trim(),
        linkedin: _linkedinController.text.trim(),
        github: _githubController.text.trim(),
        portfolio: _portfolioController.text.trim(),
        summary: _summaryController.text.trim(),
        experiences: _experiences,
        educations: _educations,
        projects: _projects,
        skills: parsedSkills,
        certifications: parsedCerts,
        languages: parsedLangs,
      ),
    );
  }

  void _fillSample() {
    final sample = ResumeModel.sample();
    setState(() {
      _populateControllers(sample);
    });
    _syncToProvider();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sample Tech Resume filled! Tap Live Preview to see layout.'),
        backgroundColor: AppColors.secondaryDark,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resume / CV Builder',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: _fillSample,
            icon: const Icon(Icons.auto_awesome, color: AppColors.secondaryDark, size: 18),
            label: Text(
              'Auto Fill',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryDark,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Live Preview Studio',
            icon: const Icon(Icons.visibility, color: AppColors.primary),
            onPressed: () {
              _syncToProvider();
              context.push('/preview-studio?category=resume');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isDesktop ? 900 : double.infinity),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildStepHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: _buildCurrentStepContent(),
                  ),
                ),
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader() {
    final steps = ['Profile', 'Experience', 'Education & Projects', 'Skills & Certs'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(bottom: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isSelected = index == _currentStep;
          final isCompleted = index < _currentStep;

          return Expanded(
            child: InkWell(
              onTap: () {
                _syncToProvider();
                setState(() => _currentStep = index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: isSelected
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.surfaceVariant,
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Profile();
      case 1:
        return _buildStep2Experience();
      case 2:
        return _buildStep3EduAndProjects();
      case 3:
        return _buildStep4SkillsAndCerts();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal & Contact Info', Icons.person_outline),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _fullNameController,
          label: 'Full Name *',
          hint: 'e.g. Vikram Aditya Sharma',
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _profTitleController,
          label: 'Professional Headline / Title *',
          hint: 'e.g. Lead Full-Stack & Mobile Architect',
          prefixIcon: const Icon(Icons.work_outline),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _emailController,
                label: 'Email Address *',
                hint: 'e.g. vikram@example.com',
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'e.g. +91 98765 43210',
                prefixIcon: const Icon(Icons.phone_outlined),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _locationController,
          label: 'Location (City, Country)',
          hint: 'e.g. Bengaluru, India',
          prefixIcon: const Icon(Icons.location_on_outlined),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _linkedinController,
                label: 'LinkedIn Profile',
                hint: 'e.g. linkedin.com/in/username',
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _githubController,
                label: 'GitHub Profile',
                hint: 'e.g. github.com/username',
                prefixIcon: const Icon(Icons.code),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _summaryController,
          label: 'Professional Summary',
          hint: 'e.g. Results-driven engineer with 5+ years of experience designing scalable systems...',
          prefixIcon: const Icon(Icons.article_outlined),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildStep2Experience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Work Experience', Icons.business_center_outlined),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Role', style: TextStyle(fontSize: 12)),
              onPressed: _showAddExperienceDialog,
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_experiences.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Text(
                'No experience added yet. Tap "+ Add Role" or click Auto-Fill.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _experiences.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final exp = _experiences[index];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            exp.role,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                          onPressed: () {
                            setState(() => _experiences.removeAt(index));
                            _syncToProvider();
                          },
                        ),
                      ],
                    ),
                    Text(
                      '${exp.company} • ${exp.startDate} - ${exp.isCurrent ? 'Present' : exp.endDate}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    if (exp.description.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        exp.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildStep3EduAndProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Education
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Education', Icons.school_outlined),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Degree', style: TextStyle(fontSize: 12)),
              onPressed: _showAddEducationDialog,
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._educations.asMap().entries.map((entry) {
          final idx = entry.key;
          final edu = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(edu.degree, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('${edu.institution} (${edu.startYear} - ${edu.endYear})', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                    onPressed: () {
                      setState(() => _educations.removeAt(idx));
                      _syncToProvider();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 20),

        // Projects
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Projects', Icons.rocket_launch_outlined),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Project', style: TextStyle(fontSize: 12)),
              onPressed: _showAddProjectDialog,
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._projects.asMap().entries.map((entry) {
          final idx = entry.key;
          final p = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        if (p.technologies.isNotEmpty)
                          Text('Tech: ${p.technologies}', style: const TextStyle(fontSize: 11, color: AppColors.primary)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                    onPressed: () {
                      setState(() => _projects.removeAt(idx));
                      _syncToProvider();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStep4SkillsAndCerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Skills & Expertise', Icons.psychology_outlined),
        const SizedBox(height: 6),
        const Text(
          'Enter your technical and soft skills separated by commas',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _skillsInputController,
          label: 'Skills (comma separated)',
          hint: 'e.g. Flutter, Dart, System Design, REST APIs, TypeScript, Agile Leadership',
          prefixIcon: const Icon(Icons.build_outlined),
          maxLines: 2,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('Certifications', Icons.verified_outlined),
        const SizedBox(height: 6),
        const Text(
          'Enter certifications separated by commas',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _certsInputController,
          label: 'Certifications (comma separated)',
          hint: 'e.g. AWS Certified Solutions Architect, Google Cloud Architect',
          prefixIcon: const Icon(Icons.card_membership_outlined),
          maxLines: 2,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('Languages', Icons.translate_outlined),
        const SizedBox(height: 6),
        const Text(
          'Enter languages separated by commas',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _langsInputController,
          label: 'Languages (comma separated)',
          hint: 'e.g. English (Fluent), Hindi (Native), German (Basic)',
          prefixIcon: const Icon(Icons.language_outlined),
        ),
      ],
    );
  }

  void _showAddExperienceDialog() {
    final roleCtl = TextEditingController();
    final companyCtl = TextEditingController();
    final startCtl = TextEditingController();
    final endCtl = TextEditingController();
    final descCtl = TextEditingController();
    bool isCurrent = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDlgState) => AlertDialog(
          title: const Text('Add Work Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: roleCtl, decoration: const InputDecoration(labelText: 'Job Title / Role *')),
                const SizedBox(height: 8),
                TextField(controller: companyCtl, decoration: const InputDecoration(labelText: 'Company / Organization *')),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: TextField(controller: startCtl, decoration: const InputDecoration(labelText: 'Start Date (e.g. 2021)'))),
                    const SizedBox(width: 8),
                    Expanded(child: TextField(controller: endCtl, enabled: !isCurrent, decoration: const InputDecoration(labelText: 'End Date (e.g. 2023)'))),
                  ],
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('I currently work here', style: TextStyle(fontSize: 13)),
                  value: isCurrent,
                  onChanged: (val) => setDlgState(() => isCurrent = val ?? false),
                ),
                TextField(controller: descCtl, maxLines: 3, decoration: const InputDecoration(labelText: 'Responsibilities / Bullet Points')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (roleCtl.text.isNotEmpty && companyCtl.text.isNotEmpty) {
                  setState(() {
                    _experiences.add(
                      ExperienceItem(
                        role: roleCtl.text.trim(),
                        company: companyCtl.text.trim(),
                        startDate: startCtl.text.trim(),
                        endDate: isCurrent ? 'Present' : endCtl.text.trim(),
                        isCurrent: isCurrent,
                        description: descCtl.text.trim(),
                      ),
                    );
                  });
                  _syncToProvider();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEducationDialog() {
    final degreeCtl = TextEditingController();
    final instCtl = TextEditingController();
    final startCtl = TextEditingController();
    final endCtl = TextEditingController();
    final scoreCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Education / Degree'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: degreeCtl, decoration: const InputDecoration(labelText: 'Degree / Course * (e.g. B.Tech CS)')),
              const SizedBox(height: 8),
              TextField(controller: instCtl, decoration: const InputDecoration(labelText: 'University / Institution *')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: TextField(controller: startCtl, decoration: const InputDecoration(labelText: 'Start Year'))),
                  const SizedBox(width: 8),
                  Expanded(child: TextField(controller: endCtl, decoration: const InputDecoration(labelText: 'End Year'))),
                ],
              ),
              const SizedBox(height: 8),
              TextField(controller: scoreCtl, decoration: const InputDecoration(labelText: 'Grade / CGPA / % (e.g. 8.5 CGPA)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (degreeCtl.text.isNotEmpty && instCtl.text.isNotEmpty) {
                setState(() {
                  _educations.add(
                    EducationItem(
                      degree: degreeCtl.text.trim(),
                      institution: instCtl.text.trim(),
                      startYear: startCtl.text.trim(),
                      endYear: endCtl.text.trim(),
                      score: scoreCtl.text.trim(),
                    ),
                  );
                });
                _syncToProvider();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddProjectDialog() {
    final titleCtl = TextEditingController();
    final techCtl = TextEditingController();
    final linkCtl = TextEditingController();
    final descCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Project'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtl, decoration: const InputDecoration(labelText: 'Project Title *')),
              const SizedBox(height: 8),
              TextField(controller: techCtl, decoration: const InputDecoration(labelText: 'Technologies Used')),
              const SizedBox(height: 8),
              TextField(controller: linkCtl, decoration: const InputDecoration(labelText: 'Project Link (e.g. github.com/...)')),
              const SizedBox(height: 8),
              TextField(controller: descCtl, maxLines: 2, decoration: const InputDecoration(labelText: 'Description / Achievements')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleCtl.text.isNotEmpty) {
                setState(() {
                  _projects.add(
                    ProjectItem(
                      title: titleCtl.text.trim(),
                      technologies: techCtl.text.trim(),
                      link: linkCtl.text.trim(),
                      description: descCtl.text.trim(),
                    ),
                  );
                });
                _syncToProvider();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: AppButton(
                text: 'Previous',
                type: AppButtonType.outline,
                onPressed: () {
                  _syncToProvider();
                  setState(() => _currentStep--);
                },
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              text: _currentStep < 3 ? 'Next Step' : 'Preview Resume',
              icon: _currentStep < 3 ? Icons.arrow_forward : Icons.remove_red_eye_outlined,
              onPressed: () {
                _syncToProvider();
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  context.push('/preview-studio?category=resume');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
