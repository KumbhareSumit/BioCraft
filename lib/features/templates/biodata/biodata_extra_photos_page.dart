import 'package:flutter/material.dart';
import '../../biodata_creator/data/models/biodata_model.dart';
import 'widgets/biodata_photo_frame.dart';

class BiodataExtraPhotosPage extends StatelessWidget {
  final BiodataModel biodata;

  const BiodataExtraPhotosPage({
    super.key,
    required this.biodata,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(biodata.primaryColorValue);
    const gold = Color(0xFFD4AF37);

    final photo1 = biodata.extraPhoto1Path;
    final photo2 = biodata.extraPhoto2Path;
    final has1 = photo1 != null && photo1.trim().isNotEmpty;
    final has2 = photo2 != null && photo2.trim().isNotEmpty;

    final bool hasBoth = has1 && has2;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        border: Border.all(color: gold, width: 3),
        boxShadow: [
          BoxShadow(
            color: gold.withValues(alpha: 0.18),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: hasBoth
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo 1
                  BiodataPhotoFrame(
                    imagePath: photo1,
                    width: 520,
                    height: 375,
                    borderWidth: 2.5,
                    borderColor: gold,
                    innerBorderColor: primaryColor.withValues(alpha: 0.5),
                    borderRadius: 8,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 18),
                  // Decorative separator
                  Container(
                    width: 120,
                    height: 1.5,
                    color: gold.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 18),
                  // Photo 2
                  BiodataPhotoFrame(
                    imagePath: photo2,
                    width: 520,
                    height: 375,
                    borderWidth: 2.5,
                    borderColor: gold,
                    innerBorderColor: primaryColor.withValues(alpha: 0.5),
                    borderRadius: 8,
                    fit: BoxFit.contain,
                  ),
                ],
              )
            : (has1 || has2)
                ? BiodataPhotoFrame(
                    imagePath: has1 ? photo1 : photo2,
                    width: 535,
                    height: 770,
                    borderWidth: 3.5,
                    borderColor: gold,
                    innerBorderColor: primaryColor.withValues(alpha: 0.6),
                    borderRadius: 12,
                    fit: BoxFit.contain,
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}
