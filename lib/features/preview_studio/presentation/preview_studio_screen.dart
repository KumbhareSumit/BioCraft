import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/services/image_exporter.dart';
import '../../../core/services/pdf_generator.dart';
import '../../../core/services/share_service.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/color_picker_widget.dart';
import '../../biodata_creator/logic/biodata_provider.dart';
import '../../invitation_creator/logic/invitation_provider.dart';
import '../../resume_creator/logic/resume_provider.dart';
import '../../templates/biodata/emerald_regal_template.dart';
import '../../templates/biodata/floral_elegance_template.dart';
import '../../templates/biodata/modern_minimal_template.dart';
import '../../templates/biodata/pastel_lavender_template.dart';
import '../../templates/biodata/royal_gold_template.dart';
import '../../templates/biodata/ruby_divine_template.dart';
import '../../templates/biodata/vintage_traditional_template.dart';
import '../../templates/invitation/baby_cradle_card.dart';
import '../../templates/invitation/floral_festive_card.dart';
import '../../templates/invitation/midnight_gold_card.dart';
import '../../templates/invitation/minimal_chic_card.dart';
import '../../templates/invitation/modern_party_card.dart';
import '../../templates/invitation/royal_wedding_card.dart';
import '../../templates/invitation/toran_grihapravesh_card.dart';
import '../../templates/resume/academic_scholar_resume.dart';
import '../../templates/resume/compact_grid_resume.dart';
import '../../templates/resume/creative_minimal_resume.dart';
import '../../templates/resume/executive_clean_resume.dart';
import '../../templates/resume/infographic_teal_resume.dart';
import '../../templates/resume/modern_tech_resume.dart';
import '../logic/preview_provider.dart';

enum StudioCategory { biodata, invitation, resume }

class PreviewStudioScreen extends StatefulWidget {
  final String? initialCategory;

  const PreviewStudioScreen({super.key, this.initialCategory});

  @override
  State<PreviewStudioScreen> createState() => _PreviewStudioScreenState();
}

class _PreviewStudioScreenState extends State<PreviewStudioScreen> {
  final GlobalKey _previewContainerKey = GlobalKey();
  final TransformationController _transformController = TransformationController();

  late StudioCategory _selectedCategory;

  final List<Map<String, String>> _biodataTemplates = [
    {'id': 'royal_gold', 'name': 'Royal Gold', 'icon': '👑'},
    {'id': 'emerald_regal', 'name': 'Emerald Regal', 'icon': '💎'},
    {'id': 'floral_elegance', 'name': 'Floral Bloom', 'icon': '🌸'},
    {'id': 'pastel_lavender', 'name': 'Pastel Lavender', 'icon': '🪻'},
    {'id': 'ruby_divine', 'name': 'Ruby Divine', 'icon': '🚩'},
    {'id': 'modern_minimal', 'name': 'Modern Minimal', 'icon': '✨'},
    {'id': 'vintage_traditional', 'name': 'Traditional Classic', 'icon': '📜'},
  ];

  final List<Map<String, String>> _invitationTemplates = [
    {'id': 'royal_wedding', 'name': 'Royal Wedding', 'icon': '💍'},
    {'id': 'midnight_gold', 'name': 'Midnight Gold', 'icon': '🌟'},
    {'id': 'floral_festive', 'name': 'Festive Floral', 'icon': '🌸'},
    {'id': 'baby_cradle', 'name': 'Baby & Cradle', 'icon': '🍼'},
    {'id': 'toran_grihapravesh', 'name': 'Griha Pravesh', 'icon': '🪔'},
    {'id': 'modern_party', 'name': 'Party & Birthday', 'icon': '🎉'},
    {'id': 'minimal_chic', 'name': 'Minimal Chic', 'icon': '✨'},
  ];

  final List<Map<String, String>> _resumeTemplates = [
    {'id': 'modern_tech', 'name': 'Modern Tech', 'icon': '💻'},
    {'id': 'infographic_teal', 'name': 'Infographic Teal', 'icon': '📊'},
    {'id': 'academic_scholar', 'name': 'Academic Scholar', 'icon': '🎓'},
    {'id': 'compact_grid', 'name': 'Compact Grid', 'icon': '⚡'},
    {'id': 'executive_clean', 'name': 'Executive ATS', 'icon': '👔'},
    {'id': 'creative_minimal', 'name': 'Creative Pro', 'icon': '🎨'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory == 'invitation') {
      _selectedCategory = StudioCategory.invitation;
    } else if (widget.initialCategory == 'resume') {
      _selectedCategory = StudioCategory.resume;
    } else {
      _selectedCategory = StudioCategory.biodata;
    }
  }

  Future<void> _exportPdf() async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final imageBytes = await ImageExporter.captureWidgetAsImage(
        _previewContainerKey,
        pixelRatio: 3.5,
      );

      final String docTitle = _getDocTitle();
      final pageFormat = _selectedCategory == StudioCategory.invitation
          ? PdfPageFormat.a5
          : PdfPageFormat.a4;

      final pdfBytes = imageBytes != null
          ? await PdfGenerator.generatePdfFromRenderedImage(imageBytes, pageFormat: pageFormat)
          : await _generateFallbackPdf();

      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: '$docTitle.pdf',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document ready for download and printing!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export PDF: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      previewProvider.setIsExporting(false);
    }
  }

  Future<void> _exportImage() async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final imageBytes = await ImageExporter.captureWidgetAsImage(_previewContainerKey, pixelRatio: 3.5);
      if (imageBytes != null) {
        final docTitle = _getDocTitle();
        await ShareService.shareImage(
          imageBytes,
          filename: '$docTitle.png',
          text: 'Check out this document created with BioCraft Studio!',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image exported successfully!'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export image: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      previewProvider.setIsExporting(false);
    }
  }

  Future<void> _sharePdf() async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final imageBytes = await ImageExporter.captureWidgetAsImage(
        _previewContainerKey,
        pixelRatio: 3.5,
      );

      final String docTitle = _getDocTitle();
      final pageFormat = _selectedCategory == StudioCategory.invitation
          ? PdfPageFormat.a5
          : PdfPageFormat.a4;

      final pdfBytes = imageBytes != null
          ? await PdfGenerator.generatePdfFromRenderedImage(imageBytes, pageFormat: pageFormat)
          : await _generateFallbackPdf();

      await ShareService.sharePdf(
        pdfBytes,
        filename: '$docTitle.pdf',
        subject: '$docTitle - BioCraft Studio',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing document: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      previewProvider.setIsExporting(false);
    }
  }

  String _getDocTitle() {
    switch (_selectedCategory) {
      case StudioCategory.biodata:
        final b = context.read<BiodataProvider>().currentBiodata;
        return b.fullName.isNotEmpty ? b.fullName.replaceAll(' ', '_') : 'Biodata';
      case StudioCategory.invitation:
        final inv = context.read<InvitationProvider>().currentInvitation;
        return inv.eventTitle.isNotEmpty ? inv.eventTitle.replaceAll(' ', '_') : 'Invitation_Card';
      case StudioCategory.resume:
        final r = context.read<ResumeProvider>().currentResume;
        return r.fullName.isNotEmpty ? '${r.fullName.replaceAll(' ', '_')}_Resume' : 'Resume';
    }
  }

  Future<Uint8List> _generateFallbackPdf() async {
    final b = context.read<BiodataProvider>().currentBiodata;
    return await PdfGenerator.generateBiodataPdf(b);
  }

  void _saveCurrentDraft() {
    switch (_selectedCategory) {
      case StudioCategory.biodata:
        context.read<BiodataProvider>().saveCurrentBiodata();
        break;
      case StudioCategory.invitation:
        context.read<InvitationProvider>().saveCurrentInvitation();
        break;
      case StudioCategory.resume:
        context.read<ResumeProvider>().saveCurrentResume();
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved locally!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _navigateToEditor() {
    switch (_selectedCategory) {
      case StudioCategory.biodata:
        context.push('/create-biodata');
        break;
      case StudioCategory.invitation:
        context.push('/create-invitation');
        break;
      case StudioCategory.resume:
        context.push('/create-resume');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final previewProvider = context.watch<PreviewProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Preview Studio',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Details',
            icon: const Icon(Icons.edit_note, color: AppColors.primary),
            onPressed: _navigateToEditor,
          ),
          IconButton(
            tooltip: 'Save Draft',
            icon: const Icon(Icons.save_outlined, color: AppColors.primary),
            onPressed: _saveCurrentDraft,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySwitchBar(),
          Expanded(
            child: isDesktop
                ? Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildCanvasArea(previewProvider),
                      ),
                      Container(width: 1, color: AppColors.border),
                      Expanded(
                        flex: 4,
                        child: _buildControlsArea(previewProvider),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _buildCanvasArea(previewProvider),
                      ),
                      _buildMobileControls(previewProvider),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySwitchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(bottom: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCategoryChip('💍 Biodata', StudioCategory.biodata),
            const SizedBox(width: 8),
            _buildCategoryChip('💌 Invitation Card', StudioCategory.invitation),
            const SizedBox(width: 8),
            _buildCategoryChip('📄 Resume / CV', StudioCategory.resume),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, StudioCategory category) {
    final isSelected = _selectedCategory == category;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedCategory = category;
            _transformController.value = Matrix4.identity();
          });
        }
      },
    );
  }

  Widget _buildCanvasArea(PreviewProvider previewProvider) {
    final double canvasWidth = _selectedCategory == StudioCategory.invitation ? 420 : 595;
    final double canvasMinHeight = _selectedCategory == StudioCategory.invitation ? 595 : 842;

    return Container(
      color: const Color(0xFFF0EBE1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                transformationController: _transformController,
                minScale: 0.2,
                maxScale: 3.0,
                boundaryMargin: const EdgeInsets.all(120),
                constrained: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: canvasWidth,
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: canvasMinHeight,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 20,
                              spreadRadius: 4,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: RepaintBoundary(
                          key: _previewContainerKey,
                          child: _buildActiveTemplateWidget(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.zoom_in, size: 20),
                        tooltip: 'Zoom In',
                        onPressed: () {
                          _transformController.value =
                              Matrix4.diagonal3Values(1.15, 1.15, 1.0) * _transformController.value;
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_out, size: 20),
                        tooltip: 'Zoom Out',
                        onPressed: () {
                          _transformController.value =
                              Matrix4.diagonal3Values(0.85, 0.85, 1.0) * _transformController.value;
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.fit_screen, size: 20),
                        tooltip: 'Fit Screen',
                        onPressed: () {
                          final double availableWidth = constraints.maxWidth - 48;
                          final double targetScale = (availableWidth / canvasWidth).clamp(0.25, 1.0);
                          _transformController.value = Matrix4.diagonal3Values(targetScale, targetScale, 1.0);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, size: 20),
                        tooltip: 'Reset Zoom (100%)',
                        onPressed: () {
                          _transformController.value = Matrix4.identity();
                        },
                      ),
                    ],
                  ),
                ),
              ),
          if (previewProvider.isExporting)
            Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('Generating document...', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    },
  ),
);
}

  Widget _buildActiveTemplateWidget() {
    switch (_selectedCategory) {
      case StudioCategory.biodata:
        final biodata = context.watch<BiodataProvider>().currentBiodata;
        switch (biodata.templateId) {
          case 'emerald_regal':
            return EmeraldRegalTemplate(biodata: biodata);
          case 'floral_elegance':
            return FloralEleganceTemplate(biodata: biodata);
          case 'pastel_lavender':
            return PastelLavenderTemplate(biodata: biodata);
          case 'ruby_divine':
            return RubyDivineTemplate(biodata: biodata);
          case 'modern_minimal':
            return ModernMinimalTemplate(biodata: biodata);
          case 'vintage_traditional':
            return VintageTraditionalTemplate(biodata: biodata);
          case 'royal_gold':
          default:
            return RoyalGoldTemplate(biodata: biodata);
        }

      case StudioCategory.invitation:
        final invitation = context.watch<InvitationProvider>().currentInvitation;
        switch (invitation.templateId) {
          case 'midnight_gold':
            return MidnightGoldCard(invitation: invitation);
          case 'floral_festive':
            return FloralFestiveCard(invitation: invitation);
          case 'baby_cradle':
            return BabyCradleCard(invitation: invitation);
          case 'toran_grihapravesh':
            return ToranGrihapraveshCard(invitation: invitation);
          case 'modern_party':
            return ModernPartyCard(invitation: invitation);
          case 'minimal_chic':
            return MinimalChicCard(invitation: invitation);
          case 'royal_wedding':
          default:
            return RoyalWeddingCard(invitation: invitation);
        }

      case StudioCategory.resume:
        final resume = context.watch<ResumeProvider>().currentResume;
        switch (resume.templateId) {
          case 'infographic_teal':
            return InfographicTealResume(resume: resume);
          case 'academic_scholar':
            return AcademicScholarResume(resume: resume);
          case 'compact_grid':
            return CompactGridResume(resume: resume);
          case 'executive_clean':
            return ExecutiveCleanResume(resume: resume);
          case 'creative_minimal':
            return CreativeMinimalResume(resume: resume);
          case 'modern_tech':
          default:
            return ModernTechResume(resume: resume);
        }
    }
  }

  Widget _buildControlsArea(PreviewProvider previewProvider) {
    final bioProvider = context.watch<BiodataProvider>();
    final invProvider = context.watch<InvitationProvider>();
    final resProvider = context.watch<ResumeProvider>();

    final List<Map<String, String>> templateList = _selectedCategory == StudioCategory.biodata
        ? _biodataTemplates
        : (_selectedCategory == StudioCategory.invitation ? _invitationTemplates : _resumeTemplates);

    final String activeTemplateId = _selectedCategory == StudioCategory.biodata
        ? bioProvider.currentBiodata.templateId
        : (_selectedCategory == StudioCategory.invitation
            ? invProvider.currentInvitation.templateId
            : resProvider.currentResume.templateId);

    final int activeColor = _selectedCategory == StudioCategory.biodata
        ? bioProvider.currentBiodata.primaryColorValue
        : (_selectedCategory == StudioCategory.invitation
            ? invProvider.currentInvitation.primaryColorValue
            : resProvider.currentResume.primaryColorValue);

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customize Design',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Template Selection
                  _buildSectionLabel('Choose Template Style'),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.3,
                    ),
                    itemCount: templateList.length,
                    itemBuilder: (context, index) {
                      final item = templateList[index];
                      final isSelected = activeTemplateId == item['id'];
                      return InkWell(
                        onTap: () {
                          if (_selectedCategory == StudioCategory.biodata) {
                            bioProvider.updateBiodata(
                              bioProvider.currentBiodata.copyWith(templateId: item['id']),
                            );
                          } else if (_selectedCategory == StudioCategory.invitation) {
                            invProvider.updateInvitation(
                              invProvider.currentInvitation.copyWith(templateId: item['id']),
                            );
                          } else {
                            resProvider.updateResume(
                              resProvider.currentResume.copyWith(templateId: item['id']),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.surfaceVariant.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Text(item['icon']!, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item['name']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Color Scheme
                  _buildSectionLabel('Theme Accent Color'),
                  const SizedBox(height: 8),
                  ColorPickerWidget(
                    selectedColor: Color(activeColor),
                    onColorChanged: (color) {
                      if (_selectedCategory == StudioCategory.biodata) {
                        bioProvider.updateBiodata(
                          bioProvider.currentBiodata.copyWith(primaryColorValue: color.toARGB32()),
                        );
                      } else if (_selectedCategory == StudioCategory.invitation) {
                        invProvider.updateInvitation(
                          invProvider.currentInvitation.copyWith(primaryColorValue: color.toARGB32()),
                        );
                      } else {
                        resProvider.updateResume(
                          resProvider.currentResume.copyWith(primaryColorValue: color.toARGB32()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Export Actions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(top: BorderSide(color: AppColors.border, width: 0.8)),
            ),
            child: Column(
              children: [
                AppButton(
                  text: 'Download Vector PDF',
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: _exportPdf,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Save Image',
                        icon: Icons.image_outlined,
                        type: AppButtonType.outline,
                        onPressed: _exportImage,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        text: 'Share',
                        icon: Icons.share_outlined,
                        type: AppButtonType.secondary,
                        onPressed: _sharePdf,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileControls(PreviewProvider previewProvider) {
    final bioProvider = context.watch<BiodataProvider>();
    final invProvider = context.watch<InvitationProvider>();
    final resProvider = context.watch<ResumeProvider>();

    final List<Map<String, String>> templateList = _selectedCategory == StudioCategory.biodata
        ? _biodataTemplates
        : (_selectedCategory == StudioCategory.invitation ? _invitationTemplates : _resumeTemplates);

    final String activeTemplateId = _selectedCategory == StudioCategory.biodata
        ? bioProvider.currentBiodata.templateId
        : (_selectedCategory == StudioCategory.invitation
            ? invProvider.currentInvitation.templateId
            : resProvider.currentResume.templateId);

    final int activeColor = _selectedCategory == StudioCategory.biodata
        ? bioProvider.currentBiodata.primaryColorValue
        : (_selectedCategory == StudioCategory.invitation
            ? invProvider.currentInvitation.primaryColorValue
            : resProvider.currentResume.primaryColorValue);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: templateList.map((t) {
                      final isSelected = activeTemplateId == t['id'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text('${t['icon']} ${t['name']}'),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              if (_selectedCategory == StudioCategory.biodata) {
                                bioProvider.updateBiodata(
                                  bioProvider.currentBiodata.copyWith(templateId: t['id']),
                                );
                              } else if (_selectedCategory == StudioCategory.invitation) {
                                invProvider.updateInvitation(
                                  invProvider.currentInvitation.copyWith(templateId: t['id']),
                                );
                              } else {
                                resProvider.updateResume(
                                  resProvider.currentResume.copyWith(templateId: t['id']),
                                );
                              }
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.palette_outlined, color: AppColors.primary),
                tooltip: 'Color Palette',
                onPressed: () => _showColorBottomSheet(activeColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Download PDF',
                  icon: Icons.picture_as_pdf,
                  onPressed: _exportPdf,
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                icon: const Icon(Icons.image_outlined),
                tooltip: 'Export Image',
                onPressed: _exportImage,
              ),
              const SizedBox(width: 4),
              IconButton.filledTonal(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'Share',
                onPressed: _sharePdf,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showColorBottomSheet(int activeColor) {
    final bioProvider = context.read<BiodataProvider>();
    final invProvider = context.read<InvitationProvider>();
    final resProvider = context.read<ResumeProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Accent Color',
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ColorPickerWidget(
                selectedColor: Color(activeColor),
                onColorChanged: (color) {
                  if (_selectedCategory == StudioCategory.biodata) {
                    bioProvider.updateBiodata(
                      bioProvider.currentBiodata.copyWith(primaryColorValue: color.toARGB32()),
                    );
                  } else if (_selectedCategory == StudioCategory.invitation) {
                    invProvider.updateInvitation(
                      invProvider.currentInvitation.copyWith(primaryColorValue: color.toARGB32()),
                    );
                  } else {
                    resProvider.updateResume(
                      resProvider.currentResume.copyWith(primaryColorValue: color.toARGB32()),
                    );
                  }
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}
