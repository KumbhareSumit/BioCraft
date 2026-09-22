import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class ModernPartyCard extends StatelessWidget {
  final InvitationModel invitation;

  const ModernPartyCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(invitation.primaryColorValue);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark Midnight
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withValues(alpha: 0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: themeColor.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sparkle emoji banner
          Text(
            invitation.titleHeading.isNotEmpty ? invitation.titleHeading : '🎉 YOU\'RE INVITED! 🎉',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          if (invitation.hostNames.isNotEmpty) ...[
            Text(
              invitation.hostNames,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: const Color(0xFFCBD5E1),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Big Event Title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: themeColor.withValues(alpha: 0.6)),
            ),
            child: Text(
              invitation.eventTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Honoree Name
          if (invitation.brideName.isNotEmpty) ...[
            Text(
              invitation.brideName,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Date & Time Neon Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 15, color: Colors.amberAccent),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        invitation.eventDate,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (invitation.eventTime.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time_filled, size: 14, color: Colors.amberAccent),
                      const SizedBox(width: 6),
                      Text(
                        invitation.eventTime,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE2E8F0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    invitation.venueName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (invitation.venueAddress.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                invitation.venueAddress,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],

          if (invitation.dressCode.isNotEmpty) ...[
            Text(
              'Dress Code: ${invitation.dressCode}',
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: Colors.amberAccent.withValues(alpha: 0.9),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
          ],

          if (invitation.rsvpDetails.isNotEmpty) ...[
            Divider(color: Colors.white24),
            const SizedBox(height: 4),
            Text(
              'RSVP: ${invitation.rsvpDetails}',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFFE2E8F0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          if (invitation.specialNote.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              invitation.specialNote,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
