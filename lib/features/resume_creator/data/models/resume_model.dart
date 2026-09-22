import 'dart:convert';

class ExperienceItem {
  final String role;
  final String company;
  final String location;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String description;

  ExperienceItem({
    this.role = '',
    this.company = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrent = false,
    this.description = '',
  });

  ExperienceItem copyWith({
    String? role,
    String? company,
    String? location,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    String? description,
  }) {
    return ExperienceItem(
      role: role ?? this.role,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'company': company,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrent': isCurrent,
      'description': description,
    };
  }

  factory ExperienceItem.fromMap(Map<String, dynamic> map) {
    return ExperienceItem(
      role: map['role'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      isCurrent: map['isCurrent'] ?? false,
      description: map['description'] ?? '',
    );
  }
}

class EducationItem {
  final String degree;
  final String institution;
  final String location;
  final String startYear;
  final String endYear;
  final String score;

  EducationItem({
    this.degree = '',
    this.institution = '',
    this.location = '',
    this.startYear = '',
    this.endYear = '',
    this.score = '',
  });

  EducationItem copyWith({
    String? degree,
    String? institution,
    String? location,
    String? startYear,
    String? endYear,
    String? score,
  }) {
    return EducationItem(
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      location: location ?? this.location,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'degree': degree,
      'institution': institution,
      'location': location,
      'startYear': startYear,
      'endYear': endYear,
      'score': score,
    };
  }

  factory EducationItem.fromMap(Map<String, dynamic> map) {
    return EducationItem(
      degree: map['degree'] ?? '',
      institution: map['institution'] ?? '',
      location: map['location'] ?? '',
      startYear: map['startYear'] ?? '',
      endYear: map['endYear'] ?? '',
      score: map['score'] ?? '',
    );
  }
}

class ProjectItem {
  final String title;
  final String technologies;
  final String link;
  final String description;

  ProjectItem({
    this.title = '',
    this.technologies = '',
    this.link = '',
    this.description = '',
  });

  ProjectItem copyWith({
    String? title,
    String? technologies,
    String? link,
    String? description,
  }) {
    return ProjectItem(
      title: title ?? this.title,
      technologies: technologies ?? this.technologies,
      link: link ?? this.link,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'technologies': technologies,
      'link': link,
      'description': description,
    };
  }

  factory ProjectItem.fromMap(Map<String, dynamic> map) {
    return ProjectItem(
      title: map['title'] ?? '',
      technologies: map['technologies'] ?? '',
      link: map['link'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class ResumeModel {
  final String id;
  final String templateId; // 'modern_tech', 'executive_clean', 'creative_minimal'
  final String fullName;
  final String professionalTitle;
  final String email;
  final String phone;
  final String location;
  final String linkedin;
  final String github;
  final String portfolio;
  final String summary;
  final List<ExperienceItem> experiences;
  final List<EducationItem> educations;
  final List<String> skills;
  final List<ProjectItem> projects;
  final List<String> certifications;
  final List<String> languages;
  final int primaryColorValue;
  final DateTime createdAt;

  ResumeModel({
    required this.id,
    this.templateId = 'modern_tech',
    this.fullName = '',
    this.professionalTitle = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.linkedin = '',
    this.github = '',
    this.portfolio = '',
    this.summary = '',
    this.experiences = const [],
    this.educations = const [],
    this.skills = const [],
    this.projects = const [],
    this.certifications = const [],
    this.languages = const [],
    this.primaryColorValue = 0xFF1E3A8A, // Deep Tech Navy
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ResumeModel copyWith({
    String? id,
    String? templateId,
    String? fullName,
    String? professionalTitle,
    String? email,
    String? phone,
    String? location,
    String? linkedin,
    String? github,
    String? portfolio,
    String? summary,
    List<ExperienceItem>? experiences,
    List<EducationItem>? educations,
    List<String>? skills,
    List<ProjectItem>? projects,
    List<String>? certifications,
    List<String>? languages,
    int? primaryColorValue,
    DateTime? createdAt,
  }) {
    return ResumeModel(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      fullName: fullName ?? this.fullName,
      professionalTitle: professionalTitle ?? this.professionalTitle,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      summary: summary ?? this.summary,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      certifications: certifications ?? this.certifications,
      languages: languages ?? this.languages,
      primaryColorValue: primaryColorValue ?? this.primaryColorValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'templateId': templateId,
      'fullName': fullName,
      'professionalTitle': professionalTitle,
      'email': email,
      'phone': phone,
      'location': location,
      'linkedin': linkedin,
      'github': github,
      'portfolio': portfolio,
      'summary': summary,
      'experiences': experiences.map((e) => e.toMap()).toList(),
      'educations': educations.map((e) => e.toMap()).toList(),
      'skills': skills,
      'projects': projects.map((e) => e.toMap()).toList(),
      'certifications': certifications,
      'languages': languages,
      'primaryColorValue': primaryColorValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ResumeModel.fromMap(Map<String, dynamic> map) {
    return ResumeModel(
      id: map['id'] ?? '',
      templateId: map['templateId'] ?? 'modern_tech',
      fullName: map['fullName'] ?? '',
      professionalTitle: map['professionalTitle'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      linkedin: map['linkedin'] ?? '',
      github: map['github'] ?? '',
      portfolio: map['portfolio'] ?? '',
      summary: map['summary'] ?? '',
      experiences: (map['experiences'] as List<dynamic>?)
              ?.map((e) => ExperienceItem.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      educations: (map['educations'] as List<dynamic>?)
              ?.map((e) => EducationItem.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      skills: (map['skills'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      projects: (map['projects'] as List<dynamic>?)
              ?.map((e) => ProjectItem.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      certifications:
          (map['certifications'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      languages: (map['languages'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      primaryColorValue: map['primaryColorValue'] ?? 0xFF1E3A8A,
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory ResumeModel.fromJson(String source) => ResumeModel.fromMap(json.decode(source));

  static ResumeModel sample() {
    return ResumeModel(
      id: 'sample_resume_${DateTime.now().millisecondsSinceEpoch}',
      templateId: 'modern_tech',
      fullName: 'Vikram Aditya Sharma',
      professionalTitle: 'Lead Full-Stack & Mobile Architect',
      email: 'vikram.sharma@example.com',
      phone: '+91 98765 43210',
      location: 'Bengaluru, India',
      linkedin: 'linkedin.com/in/vikram-sharma',
      github: 'github.com/vikramsharma',
      portfolio: 'vikramsharma.dev',
      summary:
          'Passionate software architect with 6+ years of experience designing scalable mobile and cloud applications. Expert in Flutter, Dart, TypeScript, and microservices architecture with a proven track record of leading high-performance engineering teams.',
      experiences: [
        ExperienceItem(
          role: 'Lead Mobile Architect',
          company: 'HyperScale Cloud Labs',
          location: 'Bengaluru, India',
          startDate: '2022',
          endDate: 'Present',
          isCurrent: true,
          description:
              '• Architected high-throughput cross-platform mobile apps serving 2M+ active users.\n• Reduced app cold start time by 42% through lazy-loading pipelines and render optimizations.\n• Mentored 12 engineers in clean architecture and automated CI/CD releases.',
        ),
        ExperienceItem(
          role: 'Senior Software Engineer',
          company: 'NexGen Fintech Solutions',
          location: 'Pune, India',
          startDate: '2019',
          endDate: '2022',
          isCurrent: false,
          description:
              '• Designed real-time payment gateway interfaces handling 100K daily transactions with 99.99% uptime.\n• Implemented end-to-end encryption complying with global security and PCI-DSS standards.',
        ),
      ],
      educations: [
        EducationItem(
          degree: 'B.Tech in Computer Science & Engineering',
          institution: 'Indian Institute of Technology (IIT) Bombay',
          location: 'Mumbai, India',
          startYear: '2015',
          endYear: '2019',
          score: 'CGPA: 8.9 / 10',
        ),
      ],
      skills: [
        'Flutter & Dart',
        'TypeScript / Node.js',
        'System Architecture',
        'REST & GraphQL APIs',
        'Docker & Kubernetes',
        'CI/CD & DevOps',
        'PostgreSQL & MongoDB',
        'Agile Leadership',
      ],
      projects: [
        ProjectItem(
          title: 'BioCraft Cross-Platform Studio',
          technologies: 'Flutter, Dart, PDF Vector Engine',
          link: 'github.com/biocraft-studio',
          description:
              'Open-source document creation suite enabling offline vector PDF and high-res graphic generation with 0 latency.',
        ),
        ProjectItem(
          title: 'FinPay Distributed Core',
          technologies: 'Golang, Redis, Kafka, AWS',
          link: 'finpay-core.io',
          description:
              'Event-driven ledger processing payments with sub-10ms latency and automatic reconciliation mechanisms.',
        ),
      ],
      certifications: [
        'AWS Certified Solutions Architect – Associate',
        'Google Cloud Professional Cloud Architect',
      ],
      languages: ['English (Fluent)', 'Hindi (Native)', 'Marathi (Conversational)'],
      primaryColorValue: 0xFF1E3A8A,
    );
  }
}
