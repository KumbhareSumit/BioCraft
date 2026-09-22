import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class RoyalWeddingCard extends StatelessWidget {
  final InvitationModel invitation;

  const RoyalWeddingCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(invitation.primaryColorValue);
    const goldColor = Color(0xFFD4AF37);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9F2),
        border: Border.all(color: goldColor.withValues(alpha: 0.8), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: goldColor.withValues(alpha: 0.4), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Emblem / Heading Mantra
            if (invitation.titleHeading.isNotEmpty) ...[
              Text(
                invitation.titleHeading,
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
            ],

            // Decorative Divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(color: goldColor.withValues(alpha: 0.7), thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.favorite, size: 16, color: goldColor),
                ),
                Expanded(
                  child: Divider(color: goldColor.withValues(alpha: 0.7), thickness: 1),
                ),
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
                  color: const Color(0xFF4A4A4A),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Event Title
            Text(
              invitation.eventTitle.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: themeColor,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),

            // Couple / Honoree Names
            if (invitation.brideName.isNotEmpty) ...[
              Text(
                invitation.brideName,
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              if (invitation.brideParents.isNotEmpty)
                Text(
                  invitation.brideParents,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF6B7280),
                  ),
                ),
            ],

            if (invitation.brideName.isNotEmpty && invitation.groomName.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '&',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: goldColor,
                ),
              ),
              const SizedBox(height: 8),
            ],

            if (invitation.groomName.isNotEmpty) ...[
              Text(
                invitation.groomName,
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              if (invitation.groomParents.isNotEmpty)
                Text(
                  invitation.groomParents,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: const Color(0xFF6B7280),
                  ),
                ),
            ],

            const SizedBox(height: 20),

            // Date & Time Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: goldColor.withValues(alpha: 0.5)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 16, color: themeColor),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          invitation.eventDate,
                          style: GoogleFonts.cinzel(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
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
                        Icon(Icons.access_time, size: 14, color: themeColor),
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
                'VENUE',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: goldColor,
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
              const SizedBox(height: 14),
            ],

            // Dress Code & RSVP
            if (invitation.dressCode.isNotEmpty) ...[
              Text(
                'Dress Code: ${invitation.dressCode}',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (invitation.rsvpDetails.isNotEmpty) ...[
              Divider(color: goldColor.withValues(alpha: 0.4)),
              const SizedBox(height: 6),
              Text(
                'RSVP',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                invitation.rsvpDetails,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF374151),
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
      ),
    );
  }
}
