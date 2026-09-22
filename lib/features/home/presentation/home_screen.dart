import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import '../../biodata_creator/logic/biodata_provider.dart';
import '../../invitation_creator/data/models/invitation_model.dart';
import '../../invitation_creator/logic/invitation_provider.dart';
import '../../resume_creator/data/models/resume_model.dart';
import '../../resume_creator/logic/resume_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Templates',
    '💍 Marriage Biodata',
    '💌 Invitations & Cards',
    '📄 Resumes & CVs',
  ];

  final List<Map<String, dynamic>> _templateCatalog = [
    // Biodatas
    {
      'id': 'royal_gold',
      'type': 'biodata',
      'title': 'Royal Gold Heritage',
      'category': '💍 Marriage Biodata',
      'badge': 'Premium',
      'badgeColor': AppColors.secondaryDark,
      'description': 'Opulent gold borders, ornate traditional motifs, and regal serif typography.',
      'icon': Icons.stars,
      'color': const Color(0xFF8B1E3F),
    },
    {
      'id': 'emerald_regal',
      'type': 'biodata',
      'title': 'Emerald Regal Heritage',
      'category': '💍 Marriage Biodata',
      'badge': 'Royal Luxury',
      'badgeColor': const Color(0xFF047857),
      'description': 'Royal dark emerald & gold geometry with dual-column family background.',
      'icon': Icons.spa,
      'color': const Color(0xFF064E3B),
    },
    {
      'id': 'floral_elegance',
      'type': 'biodata',
      'title': 'Floral Bloom',
      'category': '💍 Marriage Biodata',
      'badge': 'Trending',
      'badgeColor': const Color(0xFFE56B6F),
      'description': 'Soft pastel watercolor floral accents, gentle tones, and modern calligraphy.',
      'icon': Icons.local_florist,
      'color': const Color(0xFF4A154B),
    },
    {
      'id': 'pastel_lavender',
      'type': 'biodata',
      'title': 'Pastel Lavender Blossom',
      'category': '💍 Marriage Biodata',
      'badge': 'Aesthetic',
      'badgeColor': const Color(0xFF8B5CF6),
      'description': 'Dual-tone lilac cards with clean rounded segments for modern profiles.',
      'icon': Icons.yard_outlined,
      'color': const Color(0xFF6D28D9),
    },
    {
      'id': 'ruby_divine',
      'type': 'biodata',
      'title': 'Ruby Divine Temple',
      'category': '💍 Marriage Biodata',
      'badge': 'Traditional',
      'badgeColor': const Color(0xFFB91C1C),
      'description': 'Traditional South Asian deep maroon with auspicious temple borders and gotra grid.',
      'icon': Icons.temple_hindu_outlined,
      'color': const Color(0xFF7F1D1D),
    },
    {
      'id': 'modern_minimal',
      'type': 'biodata',
      'title': 'Modern Minimalist',
      'category': '💍 Marriage Biodata',
      'badge': 'Clean & Crisp',
      'badgeColor': const Color(0xFF1D3557),
      'description': 'Contemporary clean layout with clear visual hierarchy and sharp aesthetics.',
      'icon': Icons.crop_square,
      'color': const Color(0xFF1D3557),
    },
    {
      'id': 'vintage_traditional',
      'type': 'biodata',
      'title': 'Traditional Classic',
      'category': '💍 Marriage Biodata',
      'badge': 'Classic',
      'badgeColor': const Color(0xFFB07D62),
      'description': 'Authentic traditional layout with horoscope kundli section and cultural symbols.',
      'icon': Icons.history_edu,
      'color': const Color(0xFFB07D62),
    },

    // Invitations
    {
      'id': 'royal_wedding',
      'type': 'invitation',
      'title': 'Royal Wedding Card',
      'category': '💌 Invitations & Cards',
      'badge': 'Luxury Foil',
      'badgeColor': const Color(0xFFD4AF37),
      'description': 'Regal burgundy & gold foil borders, mandap motifs, and traditional fonts.',
      'icon': Icons.favorite,
      'color': const Color(0xFF8B1E3F),
    },
    {
      'id': 'midnight_gold',
      'type': 'invitation',
      'title': 'Midnight Gold Luxury',
      'category': '💌 Invitations & Cards',
      'badge': 'Dark Luxury',
      'badgeColor': const Color(0xFFF59E0B),
      'description': 'Dark obsidian aesthetic with glistening gold foil lines for luxury events.',
      'icon': Icons.nights_stay,
      'color': const Color(0xFF0F172A),
    },
    {
      'id': 'floral_festive',
      'type': 'invitation',
      'title': 'Festive Floral & Griha Pravesh',
      'category': '💌 Invitations & Cards',
      'badge': 'Festive',
      'badgeColor': const Color(0xFFD97706),
      'description': 'Pastel floral accents ideal for Engagements, Housewarming, and Anniversaries.',
      'icon': Icons.home_outlined,
      'color': const Color(0xFFD97706),
    },
    {
      'id': 'baby_cradle',
      'type': 'invitation',
      'title': 'Baby Shower & Cradle Card',
      'category': '💌 Invitations & Cards',
      'badge': 'Baby Special',
      'badgeColor': const Color(0xFF0284C7),
      'description': 'Pastel sky-blue & butter yellow palette for naming ceremonies and baby showers.',
      'icon': Icons.child_care,
      'color': const Color(0xFF0284C7),
    },
    {
      'id': 'toran_grihapravesh',
      'type': 'invitation',
      'title': 'Toran Griha Pravesh & Pooja',
      'category': '💌 Invitations & Cards',
      'badge': 'Auspicious',
      'badgeColor': const Color(0xFFEA580C),
      'description': 'Warm terracotta & saffron festive toran garland for housewarmings and poojas.',
      'icon': Icons.villa_outlined,
      'color': const Color(0xFFC2410C),
    },
    {
      'id': 'modern_party',
      'type': 'invitation',
      'title': 'Birthday & Party Pass',
      'category': '💌 Invitations & Cards',
      'badge': 'Vibrant',
      'badgeColor': const Color(0xFFE11D48),
      'description': 'Neon confetti & dark midnight layout for Birthday, Gathering, and Launch parties.',
      'icon': Icons.celebration,
      'color': const Color(0xFFE11D48),
    },
    {
      'id': 'minimal_chic',
      'type': 'invitation',
      'title': 'Minimal Chic Event Card',
      'category': '💌 Invitations & Cards',
      'badge': 'Modern',
      'badgeColor': const Color(0xFF475569),
      'description': 'Crisp typography and balanced geometry for conferences, receptions, and dinners.',
      'icon': Icons.mail_outline,
      'color': const Color(0xFF334155),
    },

    // Resumes
    {
      'id': 'modern_tech',
      'type': 'resume',
      'title': 'Modern Tech & Mobile CV',
      'category': '📄 Resumes & CVs',
      'badge': 'Tech Pro',
      'badgeColor': const Color(0xFF2563EB),
      'description': 'Two-column layout with skills sidebar, experience timeline, and project links.',
      'icon': Icons.code,
      'color': const Color(0xFF1E3A8A),
    },
    {
      'id': 'infographic_teal',
      'type': 'resume',
      'title': 'Infographic Pro Teal',
      'category': '📄 Resumes & CVs',
      'badge': 'Infographic',
      'badgeColor': const Color(0xFF0D9488),
      'description': 'Deep teal and crisp white layout with proficiency highlights and modern timeline.',
      'icon': Icons.insights,
      'color': const Color(0xFF0D9488),
    },
    {
      'id': 'academic_scholar',
      'type': 'resume',
      'title': 'Academic Scholar CV',
      'category': '📄 Resumes & CVs',
      'badge': 'ATS-Compliant',
      'badgeColor': const Color(0xFF475569),
      'description': 'Formal serif structure tailored for researchers, professors, and scholars.',
      'icon': Icons.school,
      'color': const Color(0xFF1E293B),
    },
    {
      'id': 'compact_grid',
      'type': 'resume',
      'title': 'Compact Developer Grid',
      'category': '📄 Resumes & CVs',
      'badge': 'Developer Grid',
      'badgeColor': const Color(0xFF3B82F6),
      'description': 'High-density developer grid with project cards, skill badges, and concise timeline.',
      'icon': Icons.grid_view,
      'color': const Color(0xFF2563EB),
    },
    {
      'id': 'executive_clean',
      'type': 'resume',
      'title': 'Executive Corporate ATS',
      'category': '📄 Resumes & CVs',
      'badge': 'ATS-Friendly',
      'badgeColor': const Color(0xFF059669),
      'description': 'Single-column clean corporate layout with elegant headers for senior roles.',
      'icon': Icons.business_center,
      'color': const Color(0xFF0F172A),
    },
    {
      'id': 'creative_minimal',
      'type': 'resume',
      'title': 'Creative Minimalist Resume',
      'category': '📄 Resumes & CVs',
      'badge': 'Design Pro',
      'badgeColor': const Color(0xFF7C3AED),
      'description': 'Profile card header, colored accent bars, and balanced skill chips.',
      'icon': Icons.palette,
      'color': const Color(0xFF7C3AED),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final bioProvider = context.watch<BiodataProvider>();
    final invProvider = context.watch<InvitationProvider>();
    final resProvider = context.watch<ResumeProvider>();

    final bioDrafts = bioProvider.savedBiodatas;
    final invDrafts = invProvider.savedInvitations;
    final resDrafts = resProvider.savedResumes;
    final hasAnyDrafts = bioDrafts.isNotEmpty || invDrafts.isNotEmpty || resDrafts.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_stories, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              'BioCraft',
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Live Studio',
            icon: const Icon(Icons.palette_outlined, color: AppColors.primary),
            onPressed: () => context.push('/preview-studio'),
          ),
          IconButton(
            tooltip: 'About & Features',
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1100 : double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(context),
                const SizedBox(height: 24),

                _buildStudioLaunchCards(context, bioProvider, invProvider, resProvider),
                const SizedBox(height: 28),

                if (hasAnyDrafts) ...[
                  _buildSavedDraftsHub(context, bioProvider, invProvider, resProvider),
                  const SizedBox(height: 32),
                ],

                _buildCategoryTabs(),
                const SizedBox(height: 20),

                _buildTemplatesGrid(bioProvider, invProvider, resProvider),
                const SizedBox(height: 40),

                _buildFeatureHighlights(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.secondary, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: AppColors.secondaryLight, size: 14),
                const SizedBox(width: 6),
                Text(
                  '100% Free & Offline Document Studio',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'All-In-One Document &\nInvitation Studio',
            style: GoogleFonts.cinzel(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create marriage biodatas, elegant event invitation cards, and professional job resumes with zero fees, watermarks, or accounts.',
            style: GoogleFonts.outfit(
              fontSize: 13.5,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudioLaunchCards(
    BuildContext context,
    BiodataProvider bioProvider,
    InvitationProvider invProvider,
    ResumeProvider resProvider,
  ) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    final studios = [
      {
        'title': 'Marriage Biodata',
        'subtitle': '4 Royal & Floral Templates',
        'icon': '💍',
        'gradient': [const Color(0xFF8B1E3F), const Color(0xFF5A0E24)],
        'onTap': () {
          bioProvider.createNewBiodata();
          context.push('/create-biodata');
        },
      },
      {
        'title': 'Invitation Cards',
        'subtitle': 'Wedding, Birthday & Pooja',
        'icon': '💌',
        'gradient': [const Color(0xFFD97706), const Color(0xFF92400E)],
        'onTap': () {
          invProvider.createNewInvitation();
          context.push('/create-invitation');
        },
      },
      {
        'title': 'Job Resume & CV',
        'subtitle': 'Tech & Corporate ATS Formats',
        'icon': '📄',
        'gradient': [const Color(0xFF1E3A8A), const Color(0xFF172554)],
        'onTap': () {
          resProvider.createNewResume();
          context.push('/create-resume');
        },
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (ResponsiveHelper.isTablet(context) ? 3 : 1),
        crossAxisSpacing: 14,
        mainAxisSpacing: 12,
        childAspectRatio: isDesktop ? 2.8 : (ResponsiveHelper.isTablet(context) ? 2.2 : 4.6),
      ),
      itemCount: studios.length,
      itemBuilder: (context, index) {
        final s = studios[index];
        final gradient = s['gradient'] as List<Color>;

        return InkWell(
          onTap: s['onTap'] as VoidCallback,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradient.first.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(s['icon'] as String, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        s['subtitle'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white70),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedDraftsHub(
    BuildContext context,
    BiodataProvider bioProvider,
    InvitationProvider invProvider,
    ResumeProvider resProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Saved Drafts',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/preview-studio'),
              child: const Text('Open Studio', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Saved Biodatas
        if (bioProvider.savedBiodatas.isNotEmpty) ...[
          _buildDraftSubSection<BiodataModel>(
            title: '💍 Saved Biodatas',
            drafts: bioProvider.savedBiodatas,
            getName: (d) => d.fullName.isNotEmpty ? d.fullName : 'Untitled Biodata',
            getTag: (d) => d.templateId.replaceAll('_', ' ').toUpperCase(),
            onEdit: (d) {
              bioProvider.loadBiodata(d);
              context.push('/create-biodata');
            },
            onPreview: (d) {
              bioProvider.loadBiodata(d);
              context.push('/preview-studio?category=biodata');
            },
            onDelete: (d) => bioProvider.deleteBiodata(d.id),
          ),
          const SizedBox(height: 14),
        ],

        // Saved Invitations
        if (invProvider.savedInvitations.isNotEmpty) ...[
          _buildDraftSubSection<InvitationModel>(
            title: '💌 Saved Invitations',
            drafts: invProvider.savedInvitations,
            getName: (d) => d.eventTitle.isNotEmpty ? d.eventTitle : 'Untitled Invitation',
            getTag: (d) => d.eventType.toUpperCase(),
            onEdit: (d) {
              invProvider.loadInvitation(d);
              context.push('/create-invitation');
            },
            onPreview: (d) {
              invProvider.loadInvitation(d);
              context.push('/preview-studio?category=invitation');
            },
            onDelete: (d) => invProvider.deleteInvitation(d.id),
          ),
          const SizedBox(height: 14),
        ],

        // Saved Resumes
        if (resProvider.savedResumes.isNotEmpty) ...[
          _buildDraftSubSection<ResumeModel>(
            title: '📄 Saved Resumes / CVs',
            drafts: resProvider.savedResumes,
            getName: (d) => d.fullName.isNotEmpty ? '${d.fullName} (Resume)' : 'Untitled Resume',
            getTag: (d) => d.templateId.replaceAll('_', ' ').toUpperCase(),
            onEdit: (d) {
              resProvider.loadResume(d);
              context.push('/create-resume');
            },
            onPreview: (d) {
              resProvider.loadResume(d);
              context.push('/preview-studio?category=resume');
            },
            onDelete: (d) => resProvider.deleteResume(d.id),
          ),
        ],
      ],
    );
  }

  Widget _buildDraftSubSection<T>({
    required String title,
    required List<T> drafts,
    required String Function(T) getName,
    required String Function(T) getTag,
    required void Function(T) onEdit,
    required void Function(T) onPreview,
    required void Function(T) onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        SizedBox(
          height: 125,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drafts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = drafts[index];
              final draftName = getName(item);
              final tag = getTag(item);

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onEdit(item),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 260,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                draftName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                              onPressed: () => onDelete(item),
                              tooltip: 'Delete',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.visibility_outlined, size: 16, color: AppColors.textSecondary),
                                  tooltip: 'Preview',
                                  onPressed: () => onPreview(item),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () => onEdit(item),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = index == _selectedCategoryIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_categories[index]),
              selected: isSelected,
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedCategoryIndex = index);
                }
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTemplatesGrid(
    BiodataProvider bioProvider,
    InvitationProvider invProvider,
    ResumeProvider resProvider,
  ) {
    final selectedCategory = _categories[_selectedCategoryIndex];
    final filtered = selectedCategory == 'All Templates'
        ? _templateCatalog
        : _templateCatalog.where((t) => t['category'] == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Design Templates',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : (ResponsiveHelper.isTablet(context) ? 2 : 1),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: ResponsiveHelper.isDesktop(context) ? 0.78 : (ResponsiveHelper.isTablet(context) ? 0.85 : 1.35),
          ),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final t = filtered[index];
            return _buildTemplateCard(t, bioProvider, invProvider, resProvider);
          },
        ),
      ],
    );
  }

  Widget _buildTemplateCard(
    Map<String, dynamic> item,
    BiodataProvider bioProvider,
    InvitationProvider invProvider,
    ResumeProvider resProvider,
  ) {
    final type = item['type'] as String;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (item['badgeColor'] as Color).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['badge'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: item['badgeColor'],
                  ),
                ),
              ),
              Icon(item['icon'] as IconData, color: item['color'], size: 24),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            item['title'],
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              item['description'],
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'Use Template',
            icon: Icons.edit_outlined,
            onPressed: () {
              if (type == 'biodata') {
                bioProvider.updateBiodata(
                  bioProvider.currentBiodata.copyWith(
                    templateId: item['id'],
                    primaryColorValue: (item['color'] as Color).toARGB32(),
                  ),
                );
                context.push('/create-biodata');
              } else if (type == 'invitation') {
                invProvider.updateInvitation(
                  invProvider.currentInvitation.copyWith(
                    templateId: item['id'],
                    primaryColorValue: (item['color'] as Color).toARGB32(),
                  ),
                );
                context.push('/create-invitation');
              } else {
                resProvider.updateResume(
                  resProvider.currentResume.copyWith(
                    templateId: item['id'],
                    primaryColorValue: (item['color'] as Color).toARGB32(),
                  ),
                );
                context.push('/create-resume');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {'icon': Icons.lock_outline, 'title': '100% Private', 'subtitle': 'All data stays securely on your device'},
      {'icon': Icons.picture_as_pdf, 'title': 'Vector PDF Export', 'subtitle': 'Crystal clear print output at 300+ DPI'},
      {'icon': Icons.block, 'title': 'Zero Watermarks', 'subtitle': 'Completely free & unrestricted forever'},
      {'icon': Icons.share, 'title': 'One-Tap Sharing', 'subtitle': 'Send directly via WhatsApp or Email'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose BioCraft Studio?',
            style: GoogleFonts.cinzel(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : (ResponsiveHelper.isTablet(context) ? 2 : 1),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : (ResponsiveHelper.isTablet(context) ? 3 : 3.6),
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final f = features[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(f['icon'] as IconData, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          f['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          f['subtitle'] as String,
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.auto_stories, color: AppColors.primary),
            const SizedBox(width: 8),
            Text('About BioCraft', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BioCraft is an offline, cross-platform matrimonial biodata, event invitation card, and professional resume maker designed to empower users with elegant design templates without fees, subscriptions, or watermarks.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            SizedBox(height: 12),
            Text('Version: 1.0.0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
