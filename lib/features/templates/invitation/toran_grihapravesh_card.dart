import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class ToranGrihapraveshCard extends StatelessWidget {
  final InvitationModel invitation;

  const ToranGrihapraveshCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    const terracotta = Color(0xFFC2410C);
    const saffron = Color(0xFFD97706);
    const softCream = Color(0xFFFFFBEB);
    const borderGold = Color(0xFFFBBF24);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: softCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGold, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: saffron.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Toran Garland Emojis
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('🍃', style: TextStyle(fontSize: 16)),
              SizedBox(width: 4),
              Text('🌺', style: TextStyle(fontSize: 16)),
              SizedBox(width: 4),
              Text('🪔', style: TextStyle(fontSize: 18)),
              SizedBox(width: 4),
              Text('🌺', style: TextStyle(fontSize: 16)),
              SizedBox(width: 4),
              Text('🍃', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),

          if (invitation.titleHeading.isNotEmpty) ...[
            Text(
              invitation.titleHeading,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: terracotta,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
          ],

          if (invitation.hostNames.isNotEmpty) ...[
            Text(
              invitation.hostNames,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF4A4A4A),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Event Title
          Text(
            invitation.eventTitle.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: terracotta,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 14),

          // Host / Resident Names
          if (invitation.brideName.isNotEmpty) ...[
            Text(
              invitation.brideName,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
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
            const SizedBox(height: 4),
            Text(
              '& Family',
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: saffron,
              ),
            ),
            const SizedBox(height: 4),
          ],

          if (invitation.groomName.isNotEmpty) ...[
            Text(
              invitation.groomName,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderGold.withValues(alpha: 0.8)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month, size: 16, color: terracotta),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        invitation.eventDate,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: terracotta,
                        ),
                      ),
                    ),
                  ],
                ),
                if (invitation.eventTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 13, color: saffron),
                      const SizedBox(width: 6),
                      Text(
                        invitation.eventTime,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Venue
          if (invitation.venueName.isNotEmpty) ...[
            Text(
              'NEW RESIDENCE & VENUE',
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: saffron,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              invitation.venueName,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14,
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
                  color: const Color(0xFF4B5563),
                  height: 1.3,
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],

          // RSVP & Note
          if (invitation.rsvpDetails.isNotEmpty) ...[
            Text(
              'Cordially Invited by: ${invitation.rsvpDetails}',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: terracotta,
              ),
            ),
          ],
          if (invitation.specialNote.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              invitation.specialNote,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
