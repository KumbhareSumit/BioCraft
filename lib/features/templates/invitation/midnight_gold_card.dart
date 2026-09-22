import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class MidnightGoldCard extends StatelessWidget {
  final InvitationModel invitation;

  const MidnightGoldCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    const goldAccent = Color(0xFFD4AF37);
    const goldBright = Color(0xFFFBBF24);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark Midnight Obsidian
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: goldAccent.withValues(alpha: 0.8), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: goldAccent.withValues(alpha: 0.3), width: 1.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Badge / Mantra
            if (invitation.titleHeading.isNotEmpty) ...[
              Text(
                invitation.titleHeading.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: goldBright,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Divider with Star
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: goldAccent.withValues(alpha: 0.5), thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.star, size: 14, color: goldBright),
                ),
                Expanded(child: Divider(color: goldAccent.withValues(alpha: 0.5), thickness: 1)),
              ],
            ),
            const SizedBox(height: 14),

            // Host Cordial Invitation
            if (invitation.hostNames.isNotEmpty) ...[
              Text(
                invitation.hostNames,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFCBD5E1),
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
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.5,
              ),
            ),
            const SizedBox(height: 16),

            // Honoree / Couple Names
            if (invitation.brideName.isNotEmpty) ...[
              Text(
                invitation.brideName,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: goldBright,
                ),
              ),
              if (invitation.brideParents.isNotEmpty)
                Text(
                  invitation.brideParents,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
            ],

            if (invitation.brideName.isNotEmpty && invitation.groomName.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                '✦ & ✦',
                style: GoogleFonts.cinzel(
                  fontSize: 14,
                  color: goldAccent,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 6),
            ],

            if (invitation.groomName.isNotEmpty) ...[
              Text(
                invitation.groomName,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: goldBright,
                ),
              ),
              if (invitation.groomParents.isNotEmpty)
                Text(
                  invitation.groomParents,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
            ],

            const SizedBox(height: 20),

            // Date & Time Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: goldAccent.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: goldBright),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          invitation.eventDate,
                          style: GoogleFonts.cinzel(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                        Icon(Icons.access_time, size: 13, color: goldBright),
                        const SizedBox(width: 6),
                        Text(
                          invitation.eventTime,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
              Text(
                'VENUE',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: goldAccent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                invitation.venueName,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (invitation.venueAddress.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  invitation.venueAddress,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                    height: 1.3,
                  ),
                ),
              ],
              const SizedBox(height: 14),
            ],

            // Dress Code & RSVP
            if (invitation.dressCode.isNotEmpty) ...[
              Text(
                'Dress Code: ${invitation.dressCode}',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFCBD5E1),
                ),
              ),
              const SizedBox(height: 8),
            ],

            if (invitation.rsvpDetails.isNotEmpty) ...[
              Divider(color: goldAccent.withValues(alpha: 0.3)),
              const SizedBox(height: 4),
              Text(
                'RSVP',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: goldBright,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                invitation.rsvpDetails,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
