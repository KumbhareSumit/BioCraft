import 'dart:convert';

class InvitationModel {
  final String id;
  final String templateId; // 'wedding_invitation', 'engagement_card'
  final String eventType; // 'Wedding', 'Engagement', 'Reception', 'Save the Date'
  final String titleHeading;
  final String hostNames; // e.g. "Mr. & Mrs. Rajesh Sharma cordially invite you..."
  final String brideName;
  final String brideParents;
  final String groomName;
  final String groomParents;
  final String eventDate;
  final String eventTime;
  final String venueName;
  final String venueAddress;
  final String rsvpDetails;
  final String specialNote;
  final int primaryColorValue;
  final DateTime createdAt;

  InvitationModel({
    required this.id,
    this.templateId = 'wedding_invitation',
    this.eventType = 'Wedding Invitation',
    this.titleHeading = '॥ शुभ विवाह ॥',
    this.hostNames = 'Mr. & Mrs. Rajesh Sharma cordially invite you to celebrate the wedding of',
    this.brideName = 'Ananya Verma',
    this.brideParents = 'D/o Mr. Suresh & Mrs. Sunita Verma',
    this.groomName = 'Aarav Sharma',
    this.groomParents = 'S/o Mr. Rajesh & Mrs. Geeta Sharma',
    this.eventDate = 'Sunday, 12 December 2026',
    this.eventTime = '07:00 PM Onwards',
    this.venueName = 'The Grand Imperial Palace & Resort',
    this.venueAddress = 'Senapati Bapat Road, Shivajinagar, Pune - 411016',
    this.rsvpDetails = 'Sharma & Verma Families | +91 98765 43210',
    this.specialNote = 'With Best Compliments from Near & Dear Ones',
    this.primaryColorValue = 0xFF8B1E3F,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  InvitationModel copyWith({
    String? id,
    String? templateId,
    String? eventType,
    String? titleHeading,
    String? hostNames,
    String? brideName,
    String? brideParents,
    String? groomName,
    String? groomParents,
    String? eventDate,
    String? eventTime,
    String? venueName,
    String? venueAddress,
    String? rsvpDetails,
    String? specialNote,
    int? primaryColorValue,
    DateTime? createdAt,
  }) {
    return InvitationModel(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      eventType: eventType ?? this.eventType,
      titleHeading: titleHeading ?? this.titleHeading,
      hostNames: hostNames ?? this.hostNames,
      brideName: brideName ?? this.brideName,
      brideParents: brideParents ?? this.brideParents,
      groomName: groomName ?? this.groomName,
      groomParents: groomParents ?? this.groomParents,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      venueName: venueName ?? this.venueName,
      venueAddress: venueAddress ?? this.venueAddress,
      rsvpDetails: rsvpDetails ?? this.rsvpDetails,
      specialNote: specialNote ?? this.specialNote,
      primaryColorValue: primaryColorValue ?? this.primaryColorValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'templateId': templateId,
      'eventType': eventType,
      'titleHeading': titleHeading,
      'hostNames': hostNames,
      'brideName': brideName,
      'brideParents': brideParents,
      'groomName': groomName,
      'groomParents': groomParents,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'venueName': venueName,
      'venueAddress': venueAddress,
      'rsvpDetails': rsvpDetails,
      'specialNote': specialNote,
      'primaryColorValue': primaryColorValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      id: map['id'] ?? '',
      templateId: map['templateId'] ?? 'wedding_invitation',
      eventType: map['eventType'] ?? 'Wedding Invitation',
      titleHeading: map['titleHeading'] ?? '',
      hostNames: map['hostNames'] ?? '',
      brideName: map['brideName'] ?? '',
      brideParents: map['brideParents'] ?? '',
      groomName: map['groomName'] ?? '',
      groomParents: map['groomParents'] ?? '',
      eventDate: map['eventDate'] ?? '',
      eventTime: map['eventTime'] ?? '',
      venueName: map['venueName'] ?? '',
      venueAddress: map['venueAddress'] ?? '',
      rsvpDetails: map['rsvpDetails'] ?? '',
      specialNote: map['specialNote'] ?? '',
      primaryColorValue: map['primaryColorValue'] ?? 0xFF8B1E3F,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory InvitationModel.fromJson(String source) =>
      InvitationModel.fromMap(json.decode(source));

  static InvitationModel sample() => InvitationModel(id: 'sample_invitation');
}
