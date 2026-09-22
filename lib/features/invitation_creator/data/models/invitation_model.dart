import 'dart:convert';

class InvitationModel {
  final String id;
  final String templateId; // 'royal_wedding', 'floral_festive', 'modern_party', 'minimal_chic'
  final String eventType; // 'Wedding', 'Engagement', 'Birthday', 'Housewarming', 'Anniversary', 'Baby Shower', 'Inauguration', 'Party'
  final String titleHeading; // e.g. '॥ शुभ विवाह ॥' or 'You\'re Invited!'
  final String hostNames; // e.g. "Mr. & Mrs. Rajesh Sharma cordially invite you..."
  final String eventTitle; // e.g. "Wedding Ceremony" or "Aarav's 1st Birthday"
  final String brideName; // or primary honoree
  final String brideParents;
  final String groomName; // or secondary honoree / partner
  final String groomParents;
  final String eventDate;
  final String eventTime;
  final String venueName;
  final String venueAddress;
  final String rsvpDetails;
  final String specialNote;
  final String dressCode;
  final int primaryColorValue;
  final DateTime createdAt;

  InvitationModel({
    required this.id,
    this.templateId = 'royal_wedding',
    this.eventType = 'Wedding Invitation',
    this.titleHeading = '॥ शुभ विवाह ॥',
    this.hostNames = 'Mr. & Mrs. Rajesh Sharma cordially invite you to celebrate the wedding of',
    this.eventTitle = 'Wedding Ceremony & Reception',
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
    this.dressCode = 'Traditional / Festive Attire',
    this.primaryColorValue = 0xFF8B1E3F, // Regal Maroon
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  InvitationModel copyWith({
    String? id,
    String? templateId,
    String? eventType,
    String? titleHeading,
    String? hostNames,
    String? eventTitle,
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
    String? dressCode,
    int? primaryColorValue,
    DateTime? createdAt,
  }) {
    return InvitationModel(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      eventType: eventType ?? this.eventType,
      titleHeading: titleHeading ?? this.titleHeading,
      hostNames: hostNames ?? this.hostNames,
      eventTitle: eventTitle ?? this.eventTitle,
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
      dressCode: dressCode ?? this.dressCode,
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
      'eventTitle': eventTitle,
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
      'dressCode': dressCode,
      'primaryColorValue': primaryColorValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      id: map['id'] ?? '',
      templateId: map['templateId'] ?? 'royal_wedding',
      eventType: map['eventType'] ?? 'Wedding Invitation',
      titleHeading: map['titleHeading'] ?? '',
      hostNames: map['hostNames'] ?? '',
      eventTitle: map['eventTitle'] ?? 'Wedding Ceremony & Reception',
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
      dressCode: map['dressCode'] ?? '',
      primaryColorValue: map['primaryColorValue'] ?? 0xFF8B1E3F,
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory InvitationModel.fromJson(String source) => InvitationModel.fromMap(json.decode(source));

  static InvitationModel sample({String type = 'Wedding'}) {
    final nowId = 'sample_invitation_${DateTime.now().millisecondsSinceEpoch}';
    if (type == 'Birthday') {
      return InvitationModel(
        id: nowId,
        templateId: 'modern_party',
        eventType: 'Birthday Party',
        titleHeading: '✨ Let\'s Celebrate! ✨',
        hostNames: 'Pooja & Sameer Deshmukh invite you to celebrate',
        eventTitle: 'Aarav\'s 5th Birthday Party',
        brideName: 'Aarav Deshmukh',
        brideParents: '',
        groomName: '',
        groomParents: '',
        eventDate: 'Saturday, 18 October 2026',
        eventTime: '05:30 PM - 09:00 PM',
        venueName: 'FunWorld Play & Party Lounge',
        venueAddress: 'Koregaon Park, Pune - 411001',
        rsvpDetails: 'Sameer: +91 98765 11223',
        specialNote: 'Join us for fun games, magic show, and delicious cake!',
        dressCode: 'Smart Casual / Colorful',
        primaryColorValue: 0xFFE11D48, // Vibrant Rose
      );
    } else if (type == 'Housewarming') {
      return InvitationModel(
        id: nowId,
        templateId: 'floral_festive',
        eventType: 'Griha Pravesh & Pooja',
        titleHeading: '॥ ॐ श्री गणेशाय नमः ॥',
        hostNames: 'Kulkarni Family cordially invites you to the',
        eventTitle: 'Griha Pravesh & Vastu Shanti Pooja',
        brideName: 'New Home: "Shri Krupa"',
        brideParents: '',
        groomName: 'Hosts: Sunita & Manoj Kulkarni',
        groomParents: '',
        eventDate: 'Thursday, 26 November 2026',
        eventTime: 'Pooja: 09:00 AM | Lunch: 12:30 PM',
        venueName: 'Flat 902, Tower B, Sky Gardens',
        venueAddress: 'Wakad, Pune - 411057',
        rsvpDetails: 'Manoj Kulkarni | +91 98220 33445',
        specialNote: 'Your presence and blessings will make our new home even more special.',
        dressCode: 'Traditional Attire',
        primaryColorValue: 0xFFD97706, // Festive Amber
      );
    }

    return InvitationModel(
      id: nowId,
      templateId: 'royal_wedding',
      eventType: 'Wedding Invitation',
      titleHeading: '॥ शुभ विवाह ॥',
      hostNames: 'Mr. & Mrs. Rajesh Sharma cordially invite you to celebrate the wedding of',
      eventTitle: 'Wedding Ceremony & Reception',
      brideName: 'Ananya Verma',
      brideParents: 'D/o Mr. Suresh & Mrs. Sunita Verma',
      groomName: 'Aarav Sharma',
      groomParents: 'S/o Mr. Rajesh & Mrs. Geeta Sharma',
      eventDate: 'Sunday, 12 December 2026',
      eventTime: '07:00 PM Onwards',
      venueName: 'The Grand Imperial Palace & Resort',
      venueAddress: 'Senapati Bapat Road, Shivajinagar, Pune - 411016',
      rsvpDetails: 'Sharma & Verma Families | +91 98765 43210',
      specialNote: 'With Best Compliments from Near & Dear Ones',
      dressCode: 'Traditional / Festive Attire',
      primaryColorValue: 0xFF8B1E3F,
    );
  }
}
