import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class BabyCradleCard extends StatelessWidget {
  final InvitationModel invitation;

  const BabyCradleCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    const skyBlue = Color(0xFF0284C7);
    const softBorder = Color(0xFFBAE6FD);
    const softYellow = Color(0xFFFEF3C7);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: softBorder, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: skyBlue.withValues(alpha: 0.08),
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
          // Joyful Header Emojis & Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: softYellow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🍼', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    invitation.titleHeading.isNotEmpty ? invitation.titleHeading : 'WELCOME LITTLE BLESSING',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF92400E),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text('⭐', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Host Invite
          if (invitation.hostNames.isNotEmpty) ...[
            Text(
              invitation.hostNames,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: const Color(0xFF475569),
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
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: skyBlue,
            ),
          ),
          const SizedBox(height: 12),

          // Baby / Honoree Name
          if (invitation.brideName.isNotEmpty) ...[
            Text(
              invitation.brideName,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            if (invitation.brideParents.isNotEmpty)
              Text(
                invitation.brideParents,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
              ),
          ],

          if (invitation.groomName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              invitation.groomName,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: skyBlue,
              ),
            ),
            if (invitation.groomParents.isNotEmpty)
              Text(
                invitation.groomParents,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
              ),
          ],

          const SizedBox(height: 18),

          // Date & Time Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: softBorder),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.celebration_outlined, size: 16, color: skyBlue),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        invitation.eventDate,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                if (invitation.eventTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    invitation.eventTime,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
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
              'VENUE',
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: skyBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              invitation.venueName,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            if (invitation.venueAddress.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                invitation.venueAddress,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                  height: 1.3,
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],

          // RSVP & Special Note
          if (invitation.rsvpDetails.isNotEmpty) ...[
            Text(
              'RSVP: ${invitation.rsvpDetails}',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0284C7),
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
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
