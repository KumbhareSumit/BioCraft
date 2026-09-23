import 'dart:convert';

class BiodataModel {
  final String id;
  final String templateId; // 'royal_gold', 'floral_elegance', 'modern_minimal', 'vintage_traditional', etc.
  final String religionHeading;
  final String religion;
  final int primaryColorValue;
  final String fontFamily;

  // Personal Info
  final String fullName;
  final String gender;
  final String dateOfBirth;
  final String timeOfBirth;
  final String placeOfBirth;
  final String height;
  final String complexion;
  final String bloodGroup;
  final String maritalStatus;
  final String motherTongue;
  final String caste;
  final String subCaste;
  final String gotra;
  final String rashi;
  final String nakshatra;
  final String manglik;
  final String? profileImagePath;

  // Education & Career
  final String highestEducation;
  final String educationDetails;
  final String occupation;
  final String companyName;
  final String annualIncome;
  final String workLocation;

  // Family Info
  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final String brothersCount;
  final String brotherRelation; // 'Elder', 'Younger', 'Elder & Younger', ''
  final String brotherMaritalStatus; // 'Married', 'Unmarried', 'Married & Unmarried', ''
  final String brothersDetails;
  final String sistersCount;
  final String sisterRelation; // 'Elder', 'Younger', 'Elder & Younger', ''
  final String sisterMaritalStatus; // 'Married', 'Unmarried', 'Married & Unmarried', ''
  final String sistersDetails;
  final String familyType; // Nuclear, Joint
  final String familyValues; // Traditional, Moderate, Liberal
  final String maternalUncleDetails;

  // Contact Info
  final String contactPerson;
  final String contactType; // "Father's Number", "Mother's Number", "Candidate's Number (Self)", "Brother's Number", "Guardian / Relative"
  final String contactNumber;
  final String alternateContactType; // "Father's Number", "Mother's Number", "Candidate's Number (Self)", "Brother's Number", "Guardian / Relative"
  final String alternateNumber;
  final String email;
  final String residentialAddress;
  final String nativePlace;
  final String expectations;

  final DateTime createdAt;
  final DateTime updatedAt;

  BiodataModel({
    required this.id,
    this.templateId = 'royal_gold',
    this.religionHeading = '॥ श्री गणेशाय नमः ॥',
    this.religion = 'Hindu',
    this.primaryColorValue = 0xFF8B1E3F,
    this.fontFamily = 'Outfit',
    this.fullName = '',
    this.gender = 'Male',
    this.dateOfBirth = '',
    this.timeOfBirth = '',
    this.placeOfBirth = '',
    this.height = '',
    this.complexion = '',
    this.bloodGroup = '',
    this.maritalStatus = 'Never Married',
    this.motherTongue = '',
    this.caste = '',
    this.subCaste = '',
    this.gotra = '',
    this.rashi = '',
    this.nakshatra = '',
    this.manglik = 'No',
    this.profileImagePath,
    this.highestEducation = '',
    this.educationDetails = '',
    this.occupation = '',
    this.companyName = '',
    this.annualIncome = '',
    this.workLocation = '',
    this.fatherName = '',
    this.fatherOccupation = '',
    this.motherName = '',
    this.motherOccupation = '',
    this.brothersCount = '',
    this.brotherRelation = '',
    this.brotherMaritalStatus = '',
    this.brothersDetails = '',
    this.sistersCount = '',
    this.sisterRelation = '',
    this.sisterMaritalStatus = '',
    this.sistersDetails = '',
    this.familyType = 'Nuclear',
    this.familyValues = 'Moderate',
    this.maternalUncleDetails = '',
    this.contactPerson = '',
    this.contactType = "Father's Number",
    this.contactNumber = '',
    this.alternateContactType = "Mother's Number",
    this.alternateNumber = '',
    this.email = '',
    this.residentialAddress = '',
    this.nativePlace = '',
    this.expectations = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  String get displayBrothers {
    if (brothersDetails.isNotEmpty) return brothersDetails;
    if (brothersCount.isEmpty || brothersCount == '0' || brothersCount.toLowerCase() == 'none') {
      return brothersCount.isNotEmpty ? brothersCount : 'None';
    }
    final List<String> traits = [];
    if (brotherRelation.isNotEmpty) traits.add(brotherRelation);
    if (brotherMaritalStatus.isNotEmpty) traits.add(brotherMaritalStatus);
    
    final countStr = '$brothersCount Brother${brothersCount != '1' ? 's' : ''}';
    if (traits.isNotEmpty) {
      return '$countStr (${traits.join(', ')})';
    }
    return countStr;
  }

  String get displaySisters {
    if (sistersDetails.isNotEmpty) return sistersDetails;
    if (sistersCount.isEmpty || sistersCount == '0' || sistersCount.toLowerCase() == 'none') {
      return sistersCount.isNotEmpty ? sistersCount : 'None';
    }
    final List<String> traits = [];
    if (sisterRelation.isNotEmpty) traits.add(sisterRelation);
    if (sisterMaritalStatus.isNotEmpty) traits.add(sisterMaritalStatus);
    
    final countStr = '$sistersCount Sister${sistersCount != '1' ? 's' : ''}';
    if (traits.isNotEmpty) {
      return '$countStr (${traits.join(', ')})';
    }
    return countStr;
  }

  String get displayPrimaryContact {
    if (contactNumber.isEmpty) return '';
    if (contactType.isNotEmpty && contactType != 'None') {
      return '$contactNumber ($contactType)';
    }
    return contactNumber;
  }

  String get displayAlternateContact {
    if (alternateNumber.isEmpty) return '';
    if (alternateContactType.isNotEmpty && alternateContactType != 'None') {
      return '$alternateNumber ($alternateContactType)';
    }
    return alternateNumber;
  }

  BiodataModel copyWith({
    String? id,
    String? templateId,
    String? religionHeading,
    String? religion,
    int? primaryColorValue,
    String? fontFamily,
    String? fullName,
    String? gender,
    String? dateOfBirth,
    String? timeOfBirth,
    String? placeOfBirth,
    String? height,
    String? complexion,
    String? bloodGroup,
    String? maritalStatus,
    String? motherTongue,
    String? caste,
    String? subCaste,
    String? gotra,
    String? rashi,
    String? nakshatra,
    String? manglik,
    String? profileImagePath,
    String? highestEducation,
    String? educationDetails,
    String? occupation,
    String? companyName,
    String? annualIncome,
    String? workLocation,
    String? fatherName,
    String? fatherOccupation,
    String? motherName,
    String? motherOccupation,
    String? brothersCount,
    String? brotherRelation,
    String? brotherMaritalStatus,
    String? brothersDetails,
    String? sistersCount,
    String? sisterRelation,
    String? sisterMaritalStatus,
    String? sistersDetails,
    String? familyType,
    String? familyValues,
    String? maternalUncleDetails,
    String? contactPerson,
    String? contactType,
    String? contactNumber,
    String? alternateContactType,
    String? alternateNumber,
    String? email,
    String? residentialAddress,
    String? nativePlace,
    String? expectations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BiodataModel(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      religionHeading: religionHeading ?? this.religionHeading,
      religion: religion ?? this.religion,
      primaryColorValue: primaryColorValue ?? this.primaryColorValue,
      fontFamily: fontFamily ?? this.fontFamily,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      timeOfBirth: timeOfBirth ?? this.timeOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      height: height ?? this.height,
      complexion: complexion ?? this.complexion,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      motherTongue: motherTongue ?? this.motherTongue,
      caste: caste ?? this.caste,
      subCaste: subCaste ?? this.subCaste,
      gotra: gotra ?? this.gotra,
      rashi: rashi ?? this.rashi,
      nakshatra: nakshatra ?? this.nakshatra,
      manglik: manglik ?? this.manglik,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      highestEducation: highestEducation ?? this.highestEducation,
      educationDetails: educationDetails ?? this.educationDetails,
      occupation: occupation ?? this.occupation,
      companyName: companyName ?? this.companyName,
      annualIncome: annualIncome ?? this.annualIncome,
      workLocation: workLocation ?? this.workLocation,
      fatherName: fatherName ?? this.fatherName,
      fatherOccupation: fatherOccupation ?? this.fatherOccupation,
      motherName: motherName ?? this.motherName,
      motherOccupation: motherOccupation ?? this.motherOccupation,
      brothersCount: brothersCount ?? this.brothersCount,
      brotherRelation: brotherRelation ?? this.brotherRelation,
      brotherMaritalStatus: brotherMaritalStatus ?? this.brotherMaritalStatus,
      brothersDetails: brothersDetails ?? this.brothersDetails,
      sistersCount: sistersCount ?? this.sistersCount,
      sisterRelation: sisterRelation ?? this.sisterRelation,
      sisterMaritalStatus: sisterMaritalStatus ?? this.sisterMaritalStatus,
      sistersDetails: sistersDetails ?? this.sistersDetails,
      familyType: familyType ?? this.familyType,
      familyValues: familyValues ?? this.familyValues,
      maternalUncleDetails: maternalUncleDetails ?? this.maternalUncleDetails,
      contactPerson: contactPerson ?? this.contactPerson,
      contactType: contactType ?? this.contactType,
      contactNumber: contactNumber ?? this.contactNumber,
      alternateContactType: alternateContactType ?? this.alternateContactType,
      alternateNumber: alternateNumber ?? this.alternateNumber,
      email: email ?? this.email,
      residentialAddress: residentialAddress ?? this.residentialAddress,
      nativePlace: nativePlace ?? this.nativePlace,
      expectations: expectations ?? this.expectations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'templateId': templateId,
      'religionHeading': religionHeading,
      'religion': religion,
      'primaryColorValue': primaryColorValue,
      'fontFamily': fontFamily,
      'fullName': fullName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'timeOfBirth': timeOfBirth,
      'placeOfBirth': placeOfBirth,
      'height': height,
      'complexion': complexion,
      'bloodGroup': bloodGroup,
      'maritalStatus': maritalStatus,
      'motherTongue': motherTongue,
      'caste': caste,
      'subCaste': subCaste,
      'gotra': gotra,
      'rashi': rashi,
      'nakshatra': nakshatra,
      'manglik': manglik,
      'profileImagePath': profileImagePath,
      'highestEducation': highestEducation,
      'educationDetails': educationDetails,
      'occupation': occupation,
      'companyName': companyName,
      'annualIncome': annualIncome,
      'workLocation': workLocation,
      'fatherName': fatherName,
      'fatherOccupation': fatherOccupation,
      'motherName': motherName,
      'motherOccupation': motherOccupation,
      'brothersCount': brothersCount,
      'brotherRelation': brotherRelation,
      'brotherMaritalStatus': brotherMaritalStatus,
      'brothersDetails': brothersDetails,
      'sistersCount': sistersCount,
      'sisterRelation': sisterRelation,
      'sisterMaritalStatus': sisterMaritalStatus,
      'sistersDetails': sistersDetails,
      'familyType': familyType,
      'familyValues': familyValues,
      'maternalUncleDetails': maternalUncleDetails,
      'contactPerson': contactPerson,
      'contactType': contactType,
      'contactNumber': contactNumber,
      'alternateContactType': alternateContactType,
      'alternateNumber': alternateNumber,
      'email': email,
      'residentialAddress': residentialAddress,
      'nativePlace': nativePlace,
      'expectations': expectations,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BiodataModel.fromMap(Map<String, dynamic> map) {
    return BiodataModel(
      id: map['id'] ?? '',
      templateId: map['templateId'] ?? 'royal_gold',
      religionHeading: map['religionHeading'] ?? '',
      religion: map['religion'] ?? 'Hindu',
      primaryColorValue: map['primaryColorValue'] ?? 0xFF8B1E3F,
      fontFamily: map['fontFamily'] ?? 'Outfit',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] ?? 'Male',
      dateOfBirth: map['dateOfBirth'] ?? '',
      timeOfBirth: map['timeOfBirth'] ?? '',
      placeOfBirth: map['placeOfBirth'] ?? '',
      height: map['height'] ?? '',
      complexion: map['complexion'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      maritalStatus: map['maritalStatus'] ?? 'Never Married',
      motherTongue: map['motherTongue'] ?? '',
      caste: map['caste'] ?? '',
      subCaste: map['subCaste'] ?? '',
      gotra: map['gotra'] ?? '',
      rashi: map['rashi'] ?? '',
      nakshatra: map['nakshatra'] ?? '',
      manglik: map['manglik'] ?? 'No',
      profileImagePath: map['profileImagePath'],
      highestEducation: map['highestEducation'] ?? '',
      educationDetails: map['educationDetails'] ?? '',
      occupation: map['occupation'] ?? '',
      companyName: map['companyName'] ?? '',
      annualIncome: map['annualIncome'] ?? '',
      workLocation: map['workLocation'] ?? '',
      fatherName: map['fatherName'] ?? '',
      fatherOccupation: map['fatherOccupation'] ?? '',
      motherName: map['motherName'] ?? '',
      motherOccupation: map['motherOccupation'] ?? '',
      brothersCount: map['brothersCount'] ?? '',
      brotherRelation: map['brotherRelation'] ?? '',
      brotherMaritalStatus: map['brotherMaritalStatus'] ?? '',
      brothersDetails: map['brothersDetails'] ?? '',
      sistersCount: map['sistersCount'] ?? '',
      sisterRelation: map['sisterRelation'] ?? '',
      sisterMaritalStatus: map['sisterMaritalStatus'] ?? '',
      sistersDetails: map['sistersDetails'] ?? '',
      familyType: map['familyType'] ?? 'Nuclear',
      familyValues: map['familyValues'] ?? 'Moderate',
      maternalUncleDetails: map['maternalUncleDetails'] ?? '',
      contactPerson: map['contactPerson'] ?? '',
      contactType: map['contactType'] ?? "Father's Number",
      contactNumber: map['contactNumber'] ?? '',
      alternateContactType: map['alternateContactType'] ?? "Mother's Number",
      alternateNumber: map['alternateNumber'] ?? '',
      email: map['email'] ?? '',
      residentialAddress: map['residentialAddress'] ?? '',
      nativePlace: map['nativePlace'] ?? '',
      expectations: map['expectations'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory BiodataModel.fromJson(String source) =>
      BiodataModel.fromMap(json.decode(source));

  static BiodataModel sample() {
    return BiodataModel(
      id: 'sample_biodata',
      templateId: 'royal_gold',
      religionHeading: '॥ श्री गणेशाय नमः ॥',
      religion: 'Hindu',
      fullName: 'Aarav Sharma',
      gender: 'Male',
      dateOfBirth: '14 August 1996',
      timeOfBirth: '08:45 AM',
      placeOfBirth: 'Pune, Maharashtra',
      height: '5 ft 11 in (180 cm)',
      complexion: 'Fair',
      bloodGroup: 'B+',
      maritalStatus: 'Never Married',
      motherTongue: 'Hindi / Marathi',
      caste: 'Brahmin',
      subCaste: 'Deshastha',
      gotra: 'Kashyap',
      rashi: 'Simha (Leo)',
      nakshatra: 'Magha',
      manglik: 'No',
      highestEducation: 'B.Tech in Computer Science & MS',
      educationDetails: 'IIT Bombay (B.Tech), Georgia Tech (MS)',
      occupation: 'Senior Software Engineer',
      companyName: 'Google India',
      annualIncome: '₹ 45 Lakhs p.a.',
      workLocation: 'Bengaluru / Hybrid',
      fatherName: 'Rajesh Sharma',
      fatherOccupation: 'Executive Director (Retd. Bank Officer)',
      motherName: 'Sunita Sharma',
      motherOccupation: 'Home Maker',
      brothersCount: '1',
      brotherRelation: 'Younger',
      brotherMaritalStatus: 'Unmarried',
      brothersDetails: '1 Younger Brother (Studying MBA, Unmarried)',
      sistersCount: '0',
      sisterRelation: 'None',
      sisterMaritalStatus: 'None',
      sistersDetails: 'None',
      familyType: 'Nuclear',
      familyValues: 'Moderate / Cultured',
      contactPerson: 'Rajesh Sharma (Father)',
      contactType: "Father's Number",
      contactNumber: '+91 98765 43210',
      alternateContactType: "Candidate's Number (Self)",
      alternateNumber: '+91 98231 23456',
      email: 'aarav.sharma.biodata@gmail.com',
      residentialAddress: 'Flat 402, Royal Palms, Baner, Pune - 411045',
      nativePlace: 'Pune, Maharashtra',
      expectations:
          'Looking for a well-educated, cultured and family-oriented life partner with modern outlook and mutual respect.',
    );
  }
}
