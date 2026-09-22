import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import '../../biodata_creator/logic/biodata_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All Templates', 'Royal & Classic', 'Floral Elegance', 'Modern Minimal'];

  final List<Map<String, dynamic>> _templateCatalog = [
    {
      'id': 'royal_gold',
      'title': 'Royal Gold Heritage',
      'category': 'Royal & Classic',
      'badge': 'Most Popular',
      'badgeColor': AppColors.secondaryDark,
      'description': 'Opulent gold borders, ornate traditional motifs, and regal serif typography.',
      'icon': Icons.stars,
      'color': const Color(0xFF8B1E3F),
    },
    {
      'id': 'floral_elegance',
      'title': 'Floral Elegance',
      'category': 'Floral Elegance',
      'badge': 'Trending',
      'badgeColor': const Color(0xFFE56B6F),
      'description': 'Soft pastel watercolor floral accents, gentle tones, and modern calligraphy.',
      'icon': Icons.local_florist,
      'color': const Color(0xFF4A154B),
    },
    {
      'id': 'modern_minimal',
      'title': 'Modern Minimalist',
      'category': 'Modern Minimal',
      'badge': 'Clean & Crisp',
      'badgeColor': const Color(0xFF1D3557),
      'description': 'Contemporary clean layout with clear visual hierarchy and sharp aesthetics.',
      'icon': Icons.crop_square,
      'color': const Color(0xFF1D3557),
    },
    {
      'id': 'vintage_traditional',
      'title': 'Vintage Traditional',
      'category': 'Royal & Classic',
      'badge': 'Classic',
      'badgeColor': const Color(0xFFB07D62),
      'description': 'Authentic traditional layout with horoscope kundli section and cultural symbols.',
      'icon': Icons.history_edu,
      'color': const Color(0xFFB07D62),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final bioProvider = context.watch<BiodataProvider>();
    final savedDrafts = bioProvider.savedBiodatas;

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
                const SizedBox(height: 28),

                if (savedDrafts.isNotEmpty) ...[
                  _buildSavedDraftsSection(savedDrafts, bioProvider),
                  const SizedBox(height: 32),
                ],

                _buildCategoryTabs(),
                const SizedBox(height: 20),

                _buildTemplatesGrid(bioProvider),
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
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      '100% Free & Offline Biodata Maker',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Create Stunning Marriage\nBiodatas in Minutes',
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Choose from premium royal, floral, and modern minimalist templates. Export in print-ready Vector PDF & High-Res PNG with zero watermarks.',
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                onPressed: () {
                  context.read<BiodataProvider>().createNewBiodata();
                  context.push('/create-biodata');
                },
                icon: const Icon(Icons.add, size: 20),
                label: Text(
                  'Create Biodata Now',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70, width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => context.push('/preview-biodata'),
                icon: const Icon(Icons.visibility_outlined, size: 18),
                label: Text(
                  'Live Preview Studio',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedDraftsSection(List<BiodataModel> drafts, BiodataProvider bioProvider) {
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
            Text(
              '${drafts.length} draft(s)',
              style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drafts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final draft = drafts[index];
              final title = draft.fullName.isNotEmpty ? draft.fullName : 'Untitled Biodata';

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    bioProvider.loadBiodata(draft);
                    context.push('/create-biodata');
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 270,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(draft.primaryColorValue).withValues(alpha: 0.15),
                              child: Icon(Icons.person, color: Color(draft.primaryColorValue), size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                              onPressed: () => bioProvider.deleteBiodata(draft.id),
                              tooltip: 'Delete Draft',
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
                                draft.templateId.replaceAll('_', ' ').toUpperCase(),
                                style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.visibility_outlined, size: 18, color: AppColors.textSecondary),
                                  tooltip: 'Preview',
                                  onPressed: () {
                                    bioProvider.loadBiodata(draft);
                                    context.push('/preview-biodata');
                                  },
                                ),
                                const SizedBox(width: 6),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  ),
                                  icon: const Icon(Icons.edit_outlined, size: 14),
                                  label: const Text('Edit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    bioProvider.loadBiodata(draft);
                                    context.push('/create-biodata');
                                  },
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

  Widget _buildTemplatesGrid(BiodataProvider bioProvider) {
    final selectedCategory = _categories[_selectedCategoryIndex];
    final filtered = selectedCategory == 'All Templates'
        ? _templateCatalog
        : _templateCatalog.where((t) => t['category'] == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Biodata Templates',
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
            return _buildTemplateCard(t, bioProvider);
          },
        ),
      ],
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> item, BiodataProvider bioProvider) {
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
              Icon(item['icon'], color: item['color'], size: 24),
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
              bioProvider.updateBiodata(
                bioProvider.currentBiodata.copyWith(
                  templateId: item['id'],
                  primaryColorValue: (item['color'] as Color).toARGB32(),
                ),
              );
              context.push('/create-biodata');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {'icon': Icons.lock_outline, 'title': '100% Private', 'subtitle': 'All data stays on your device'},
      {'icon': Icons.picture_as_pdf, 'title': 'Vector PDF', 'subtitle': 'Crystal clear print output'},
      {'icon': Icons.block, 'title': 'No Watermark', 'subtitle': 'Completely free & unrestricted'},
      {'icon': Icons.share, 'title': 'Quick Share', 'subtitle': 'Send directly on WhatsApp'},
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
            'Why Choose BioCraft?',
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
              'BioCraft is an offline, cross-platform matrimonial biodata & invitation maker created to empower families and candidates with elegant design templates without fees, subscriptions, or watermarks.',
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
