import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class FloralFestiveCard extends StatelessWidget {
  final InvitationModel invitation;

  const FloralFestiveCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(invitation.primaryColorValue);
    const softBorder = Color(0xFFF9A8D4); // Soft pink accent

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: softBorder.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Floral Motifs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🌸', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              if (invitation.titleHeading.isNotEmpty)
                Flexible(
                  child: Text(
                    invitation.titleHeading,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
              const SizedBox(width: 6),
              const Text('🌸', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),

          if (invitation.hostNames.isNotEmpty) ...[
            Text(
              invitation.hostNames,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: const Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Event Title
          Text(
            invitation.eventTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
          const SizedBox(height: 14),

          // Main Honoree / Couple Names
          if (invitation.brideName.isNotEmpty) ...[
            Text(
              invitation.brideName,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            if (invitation.brideParents.isNotEmpty)
              Text(
                invitation.brideParents,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF6B7280)),
              ),
          ],

          if (invitation.brideName.isNotEmpty && invitation.groomName.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'with',
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 6),
          ],

          if (invitation.groomName.isNotEmpty) ...[
            Text(
              invitation.groomName,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            if (invitation.groomParents.isNotEmpty)
              Text(
                invitation.groomParents,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF6B7280)),
              ),
          ],

          const SizedBox(height: 18),

          // Date & Time Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  invitation.eventDate,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                if (invitation.eventTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    invitation.eventTime,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Venue
          if (invitation.venueName.isNotEmpty) ...[
            Text(
              '📍 ${invitation.venueName}',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
            if (invitation.venueAddress.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                invitation.venueAddress,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],

          if (invitation.rsvpDetails.isNotEmpty) ...[
            Divider(color: Colors.pink.withValues(alpha: 0.2)),
            const SizedBox(height: 6),
            Text(
              'RSVP: ${invitation.rsvpDetails}',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          if (invitation.specialNote.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              invitation.specialNote,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
