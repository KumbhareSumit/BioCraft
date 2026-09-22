import 'package:flutter/material.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colors;

  const ColorPickerWidget({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
    this.colors,
  });

  static const List<Color> defaultPalette = [
    Color(0xFF8B1E3F), // Royal Maroon
    Color(0xFFD4AF37), // Royal Gold
    Color(0xFF1D3557), // Classic Navy
    Color(0xFF2A9D8F), // Emerald Teal
    Color(0xFF4A154B), // Aubergine / Royal Purple
    Color(0xFFB07D62), // Warm Terracotta
    Color(0xFF2B2D42), // Charcoal Modern
    Color(0xFFE56B6F), // Rose Gold
    Color(0xFF588157), // Sage Olive
    Color(0xFF000000), // Pure Black
  ];

  @override
  Widget build(BuildContext context) {
    final palette = colors ?? defaultPalette;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: palette.map((color) {
          final isSelected = selectedColor.toARGB32() == color.toARGB32();
          return GestureDetector(
            onTap: () => onColorChanged(color),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.black12,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
