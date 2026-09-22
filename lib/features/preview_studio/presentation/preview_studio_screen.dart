import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/services/image_exporter.dart';
import '../../../core/services/pdf_generator.dart';
import '../../../core/services/share_service.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/color_picker_widget.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import '../../biodata_creator/logic/biodata_provider.dart';
import '../../templates/biodata/floral_elegance_template.dart';
import '../../templates/biodata/modern_minimal_template.dart';
import '../../templates/biodata/royal_gold_template.dart';
import '../../templates/biodata/vintage_traditional_template.dart';
import '../logic/preview_provider.dart';

class PreviewStudioScreen extends StatefulWidget {
  const PreviewStudioScreen({super.key});

  @override
  State<PreviewStudioScreen> createState() => _PreviewStudioScreenState();
}

class _PreviewStudioScreenState extends State<PreviewStudioScreen> {
  final GlobalKey _previewContainerKey = GlobalKey();
  final TransformationController _transformController = TransformationController();

  final List<Map<String, String>> _templates = [
    {'id': 'royal_gold', 'name': 'Royal Gold', 'icon': '👑'},
    {'id': 'floral_elegance', 'name': 'Floral Elegance', 'icon': '🌸'},
    {'id': 'modern_minimal', 'name': 'Modern Minimal', 'icon': '✨'},
    {'id': 'vintage_traditional', 'name': 'Vintage Classic', 'icon': '📜'},
  ];

  final List<String> _religionHeadings = [
    '॥ श्री गणेशाय नमः ॥',
    '॥ श्री महालक्ष्मी प्रसन्न ॥',
    '॥ ॐ नमः शिवाय ॥',
    '॥ श्री कुलदेवतायै नमः ॥',
    'ੴ ਸਤਿਗੁਰ ਪ੍ਰਸਾਦਿ',
    'In the Name of Allah, Most Gracious',
    '|| Jai Jinendra ||',
    '✝ God Bless This Union ✝',
    '',
  ];

  Future<void> _exportPdf(BiodataModel biodata) async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final pdfBytes = await PdfGenerator.generateBiodataPdf(biodata);
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: '${biodata.fullName.replaceAll(' ', '_')}_Biodata.pdf',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF ready for printing and download!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      previewProvider.setIsExporting(false);
    }
  }

  Future<void> _exportImage(BiodataModel biodata) async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final imageBytes = await ImageExporter.captureWidgetAsImage(_previewContainerKey);
      if (imageBytes != null) {
        await ShareService.shareImage(
          imageBytes,
          filename: '${biodata.fullName.replaceAll(' ', '_')}_Biodata.png',
          text: 'Check out this biodata created with BioCraft!',
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

  Future<void> _sharePdf(BiodataModel biodata) async {
    final previewProvider = context.read<PreviewProvider>();
    previewProvider.setIsExporting(true);
    try {
      final pdfBytes = await PdfGenerator.generateBiodataPdf(biodata);
      await ShareService.sharePdf(
        pdfBytes,
        filename: '${biodata.fullName.replaceAll(' ', '_')}_Biodata.pdf',
        subject: '${biodata.fullName} - Matrimonial Biodata',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      previewProvider.setIsExporting(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final bioProvider = context.watch<BiodataProvider>();
    final biodata = bioProvider.currentBiodata;
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
            onPressed: () => context.pop(),
          ),
          IconButton(
            tooltip: 'Save Draft',
            icon: const Icon(Icons.save_outlined, color: AppColors.primary),
            onPressed: () {
              bioProvider.saveCurrentBiodata();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Draft saved locally!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: isDesktop
          ? Row(
              children: [
                Expanded(
                  flex: 6,
                  child: _buildCanvasArea(biodata, previewProvider),
                ),
                Container(width: 1, color: AppColors.border),
                Expanded(
                  flex: 4,
                  child: _buildControlsArea(biodata, bioProvider, previewProvider),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: _buildCanvasArea(biodata, previewProvider),
                ),
                _buildMobileControls(biodata, bioProvider, previewProvider),
              ],
            ),
    );
  }

  Widget _buildCanvasArea(BiodataModel biodata, PreviewProvider previewProvider) {
    return Container(
      color: const Color(0xFFF0EBE1),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            transformationController: _transformController,
            minScale: 0.4,
            maxScale: 2.5,
            boundaryMargin: const EdgeInsets.all(80),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 595), // A4 ratio width
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
                      child: _buildTemplateWidget(biodata),
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
                      _transformController.value = Matrix4.diagonal3Values(1.15, 1.15, 1.0) * _transformController.value;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_out, size: 20),
                    tooltip: 'Zoom Out',
                    onPressed: () {
                      _transformController.value = Matrix4.diagonal3Values(0.85, 0.85, 1.0) * _transformController.value;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 20),
                    tooltip: 'Reset Zoom',
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
      ),
    );
  }

  Widget _buildTemplateWidget(BiodataModel biodata) {
    switch (biodata.templateId) {
      case 'floral_elegance':
        return FloralEleganceTemplate(biodata: biodata);
      case 'modern_minimal':
        return ModernMinimalTemplate(biodata: biodata);
      case 'vintage_traditional':
        return VintageTraditionalTemplate(biodata: biodata);
      case 'royal_gold':
      default:
        return RoyalGoldTemplate(biodata: biodata);
    }
  }

  Widget _buildControlsArea(
    BiodataModel biodata,
    BiodataProvider bioProvider,
    PreviewProvider previewProvider,
  ) {
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
                    itemCount: _templates.length,
                    itemBuilder: (context, index) {
                      final item = _templates[index];
                      final isSelected = biodata.templateId == item['id'];
                      return InkWell(
                        onTap: () {
                          bioProvider.updateBiodata(biodata.copyWith(templateId: item['id']));
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
                    selectedColor: Color(biodata.primaryColorValue),
                    onColorChanged: (color) {
                      bioProvider.updateBiodata(biodata.copyWith(primaryColorValue: color.toARGB32()));
                    },
                  ),
                  const SizedBox(height: 20),

                  // Religious Heading Emblem
                  _buildSectionLabel('Header Mantra / Symbol'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _religionHeadings.contains(biodata.religionHeading)
                        ? biodata.religionHeading
                        : _religionHeadings.first,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: _religionHeadings.map((heading) {
                      return DropdownMenuItem<String>(
                        value: heading,
                        child: Text(
                          heading.isEmpty ? 'None (Clean Modern)' : heading,
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        bioProvider.updateBiodata(biodata.copyWith(religionHeading: val));
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
                  text: 'Download Vector PDF (A4)',
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: () => _exportPdf(biodata),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Save Image',
                        icon: Icons.image_outlined,
                        type: AppButtonType.outline,
                        onPressed: () => _exportImage(biodata),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        text: 'Share',
                        icon: Icons.share_outlined,
                        type: AppButtonType.secondary,
                        onPressed: () => _sharePdf(biodata),
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

  Widget _buildMobileControls(
    BiodataModel biodata,
    BiodataProvider bioProvider,
    PreviewProvider previewProvider,
  ) {
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
                    children: _templates.map((t) {
                      final isSelected = biodata.templateId == t['id'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text('${t['icon']} ${t['name']}'),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              bioProvider.updateBiodata(biodata.copyWith(templateId: t['id']));
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
                onPressed: () => _showColorBottomSheet(biodata, bioProvider),
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
                  onPressed: () => _exportPdf(biodata),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                icon: const Icon(Icons.image_outlined),
                tooltip: 'Export Image',
                onPressed: () => _exportImage(biodata),
              ),
              const SizedBox(width: 4),
              IconButton.filledTonal(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'Share',
                onPressed: () => _sharePdf(biodata),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showColorBottomSheet(BiodataModel biodata, BiodataProvider bioProvider) {
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
                selectedColor: Color(biodata.primaryColorValue),
                onColorChanged: (color) {
                  bioProvider.updateBiodata(biodata.copyWith(primaryColorValue: color.toARGB32()));
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
