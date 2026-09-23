import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BiodataPhotoFrame extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final Color borderColor;
  final Color? innerBorderColor;
  final double borderWidth;
  final double borderRadius;
  final bool showShadow;

  const BiodataPhotoFrame({
    super.key,
    required this.imagePath,
    this.width = 100,
    this.height = 125,
    this.borderColor = const Color(0xFFD4AF37), // Gold
    this.innerBorderColor,
    this.borderWidth = 2.0,
    this.borderRadius = 6.0,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.trim().isNotEmpty;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: borderColor.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.all(innerBorderColor != null ? 2.5 : 0),
      child: innerBorderColor != null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius > 2 ? borderRadius - 2 : 2),
                border: Border.all(color: innerBorderColor!, width: 1.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius > 3 ? borderRadius - 3 : 1),
                child: _buildImageContent(hasImage),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius > 1 ? borderRadius - 1 : 1),
              child: _buildImageContent(hasImage),
            ),
    );
  }

  Widget _buildImageContent(bool hasImage) {
    if (!hasImage) {
      return Container(
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: width * 0.45, color: Colors.grey.shade400),
            const SizedBox(height: 2),
            Text(
              'PHOTO',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    final path = imagePath!.trim();

    if (kIsWeb || path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(Icons.person, size: width * 0.45, color: Colors.grey.shade400),
      ),
    );
  }
}
