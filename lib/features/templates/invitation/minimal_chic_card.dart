import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../invitation_creator/data/models/invitation_model.dart';

class MinimalChicCard extends StatelessWidget {
  final InvitationModel invitation;

  const MinimalChicCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(invitation.primaryColorValue);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top pill badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              invitation.titleHeading.isNotEmpty ? invitation.titleHeading : 'CORDIALLY INVITED',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: themeColor,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 14),

          if (invitation.hostNames.isNotEmpty) ...[
            Text(
              invitation.hostNames,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Event Title
          Text(
            invitation.eventTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          if (invitation.brideName.isNotEmpty) ...[
            Text(
              invitation.brideName,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            if (invitation.brideParents.isNotEmpty)
              Text(
                invitation.brideParents,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
              ),
          ],

          if (invitation.brideName.isNotEmpty && invitation.groomName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '— AND —',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF94A3B8),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
          ],

          if (invitation.groomName.isNotEmpty) ...[
            Text(
              invitation.groomName,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
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

          // Date & Venue Grid
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 16, color: themeColor),
                      const SizedBox(height: 4),
                      Text(
                        invitation.eventDate,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      if (invitation.eventTime.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          invitation.eventTime,
                          style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: themeColor),
                      const SizedBox(height: 4),
                      Text(
                        invitation.venueName.isNotEmpty ? invitation.venueName : 'Venue',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      if (invitation.venueAddress.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          invitation.venueAddress,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          if (invitation.rsvpDetails.isNotEmpty) ...[
            Text(
              'RSVP: ${invitation.rsvpDetails}',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFF475569),
                fontWeight: FontWeight.w600,
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
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
