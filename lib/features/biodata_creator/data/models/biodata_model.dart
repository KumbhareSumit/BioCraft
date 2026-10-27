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
  final String devak;
  final String rashi;
  final String nakshatra;
  final String charan;
  final String gan;
  final String nadi;
  final String manglik;
  final String kuldaivat;
  final String? profileImagePath;
  final String? extraPhoto1Path;
  final String? extraPhoto2Path;

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
    this.devak = '',
    this.rashi = '',
    this.nakshatra = '',
    this.charan = '',
    this.gan = '',
    this.nadi = '',
    this.manglik = 'No',
    this.kuldaivat = '',
    this.profileImagePath,
    this.extraPhoto1Path,
    this.extraPhoto2Path,
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

  static bool isValuePresent(String? value) {
    if (value == null) return false;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    final lower = trimmed.toLowerCase();
    return lower != 'none' &&
        lower != 'n/a' &&
        lower != 'na' &&
        lower != 'nil' &&
        lower != 'not specified' &&
        lower != 'null' &&
        lower != '-' &&
        lower != '--' &&
        lower != '|' &&
        lower != '/' &&
        lower != '()';
  }

  bool get hasBrothers {
    if (brothersCount.isEmpty && brothersDetails.isEmpty) return false;
    final count = brothersCount.trim().toLowerCase();
    final details = brothersDetails.trim().toLowerCase();
    if (!BiodataModel.isValuePresent(count) && !BiodataModel.isValuePresent(details)) {
      return false;
    }
    if (count == '0' || details == '0' || count == 'no' || details == 'no') return false;
    return true;
  }

  bool get hasSisters {
    if (sistersCount.isEmpty && sistersDetails.isEmpty) return false;
    final count = sistersCount.trim().toLowerCase();
    final details = sistersDetails.trim().toLowerCase();
    if (!BiodataModel.isValuePresent(count) && !BiodataModel.isValuePresent(details)) {
      return false;
    }
    if (count == '0' || details == '0' || count == 'no' || details == 'no') return false;
    return true;
  }

  String get displayBrothers {
    if (!hasBrothers) return '';
    if (brothersDetails.isNotEmpty && BiodataModel.isValuePresent(brothersDetails)) {
      return brothersDetails;
    }
    final List<String> traits = [];
    if (brotherRelation.isNotEmpty && BiodataModel.isValuePresent(brotherRelation)) {
      if (brotherRelation == 'Both' || brotherRelation == 'Both (Elder & Younger)') {
        traits.add('Elder & Younger');
      } else {
        traits.add(brotherRelation);
      }
    }
    if (brotherMaritalStatus.isNotEmpty && BiodataModel.isValuePresent(brotherMaritalStatus)) {
      if (brotherMaritalStatus == 'Both' || brotherMaritalStatus == 'Both (Married & Unmarried)') {
        traits.add('Married & Unmarried');
      } else {
        traits.add(brotherMaritalStatus);
      }
    }
    
    final countStr = '$brothersCount Brother${brothersCount != '1' ? 's' : ''}';
    if (traits.isNotEmpty) {
      return '$countStr (${traits.join(', ')})';
    }
    return countStr;
  }

  String get displaySisters {
    if (!hasSisters) return '';
    if (sistersDetails.isNotEmpty && BiodataModel.isValuePresent(sistersDetails)) {
      return sistersDetails;
    }
    final List<String> traits = [];
    if (sisterRelation.isNotEmpty && BiodataModel.isValuePresent(sisterRelation)) {
      if (sisterRelation == 'Both' || sisterRelation == 'Both (Elder & Younger)') {
        traits.add('Elder & Younger');
      } else {
        traits.add(sisterRelation);
      }
    }
    if (sisterMaritalStatus.isNotEmpty && BiodataModel.isValuePresent(sisterMaritalStatus)) {
      if (sisterMaritalStatus == 'Both' || sisterMaritalStatus == 'Both (Married & Unmarried)') {
        traits.add('Married & Unmarried');
      } else {
        traits.add(sisterMaritalStatus);
      }
    }
    
    final countStr = '$sistersCount Sister${sistersCount != '1' ? 's' : ''}';
    if (traits.isNotEmpty) {
      return '$countStr (${traits.join(', ')})';
    }
    return countStr;
  }

  bool get hasFamilyType => BiodataModel.isValuePresent(familyType);

  String get displayFamilyType {
    if (!hasFamilyType) return '';
    return '$familyType Family';
  }

  bool get hasFamilyValues => BiodataModel.isValuePresent(familyValues);

  String get displayFamilyValues {
    if (!hasFamilyValues) return '';
    return '$familyValues Values';
  }

  static String _formatNameTitle(String text) {
    if (!BiodataModel.isValuePresent(text)) return '';
    final words = text.trim().split(RegExp(r'\s+'));
    return words.map((w) {
      final lower = w.toLowerCase();
      if (lower == 'shri' || lower == 'shree') return 'Shri';
      if (lower == 'smt' || lower == 'smt.') return 'Smt.';
      if (lower == 'mr' || lower == 'mr.') return 'Mr.';
      if (lower == 'mrs' || lower == 'mrs.') return 'Mrs.';
      if (lower == 'dr' || lower == 'dr.') return 'Dr.';
      if (w.length <= 1) return w.toUpperCase();
      return w[0].toUpperCase() + w.substring(1);
    }).join(' ');
  }

  static String _formatOccupation(String text) {
    var occ = text.trim();
    if (!BiodataModel.isValuePresent(occ)) return '';
    if (occ.startsWith('(') && occ.endsWith(')')) {
      occ = occ.substring(1, occ.length - 1).trim();
    }
    final lower = occ.toLowerCase();
    if (lower == 'homemaker' || lower == 'housewife' || lower == 'house wife') {
      return 'Homemaker';
    }
    if (lower == 'government' || lower == 'govt') {
      return 'Govt. Employee';
    }
    if (lower == 'private') {
      return 'Private Sector';
    }
    if (occ.length <= 1) return occ.toUpperCase();
    return occ[0].toUpperCase() + occ.substring(1);
  }

  String get displayFatherDetails {
    final name = _formatNameTitle(fatherName);
    final occ = _formatOccupation(fatherOccupation);
    final hasName = BiodataModel.isValuePresent(name);
    final hasOcc = BiodataModel.isValuePresent(occ);
    if (!hasName && !hasOcc) return '';
    if (hasName && hasOcc) return '$name ($occ)';
    return hasName ? name : occ;
  }

  String get displayMotherDetails {
    final name = _formatNameTitle(motherName);
    final occ = _formatOccupation(motherOccupation);
    final hasName = BiodataModel.isValuePresent(name);
    final hasOcc = BiodataModel.isValuePresent(occ);
    if (!hasName && !hasOcc) return '';
    if (hasName && hasOcc) return '$name ($occ)';
    return hasName ? name : occ;
  }

  String get displayMaternalUncle {
    final name = _formatNameTitle(maternalUncleDetails);
    return BiodataModel.isValuePresent(name) ? name : '';
  }

  String get primaryContactLabel {
    final type = contactType.trim();
    if (type.contains("Father")) return "Father's Mobile";
    if (type.contains("Mother")) return "Mother's Mobile";
    if (type.contains("Candidate") || type.contains("Self")) return "Candidate's Mobile";
    if (type.contains("Brother")) return "Brother's Mobile";
    if (type.contains("Guardian") || type.contains("Relative")) return "Guardian's Mobile";
    if (type.contains("Family")) return "Family Contact";
    if (type.isNotEmpty && type != 'None') return '$type Mobile';
    return 'Contact Number';
  }

  String get alternateContactLabel {
    final type = alternateContactType.trim();
    if (type.contains("Father")) return "Father's Mobile";
    if (type.contains("Mother")) return "Mother's Mobile";
    if (type.contains("Candidate") || type.contains("Self")) return "Candidate's Mobile";
    if (type.contains("Brother")) return "Brother's Mobile";
    if (type.contains("Guardian") || type.contains("Relative")) return "Guardian's Mobile";
    if (type.isNotEmpty && type != 'None' && type != 'None / Other') return '$type Mobile';
    return 'Alternate Number';
  }

  String get primaryContactLabelHindi {
    final type = contactType.trim();
    if (type.contains("Father")) return "पिताजी का मोबाइल";
    if (type.contains("Mother")) return "माताजी का मोबाइल";
    if (type.contains("Candidate") || type.contains("Self")) return "प्रत्याशी का मोबाइल";
    if (type.contains("Brother")) return "भाई का मोबाइल";
    if (type.contains("Guardian") || type.contains("Relative")) return "अभिभावक का मोबाइल";
    return 'मोबाइल नंबर';
  }

  String get alternateContactLabelHindi {
    final type = alternateContactType.trim();
    if (type.contains("Father")) return "पिताजी का मोबाइल";
    if (type.contains("Mother")) return "माताजी का मोबाइल";
    if (type.contains("Candidate") || type.contains("Self")) return "प्रत्याशी का मोबाइल";
    if (type.contains("Brother")) return "भाई का मोबाइल";
    if (type.contains("Guardian") || type.contains("Relative")) return "अभिभावक का मोबाइल";
    return 'वैकल्पिक नंबर';
  }

  String get displayPrimaryContact {
    return contactNumber.trim();
  }

  String get displayAlternateContact {
    return alternateNumber.trim();
  }

  // Astrology Display Helpers
  String get displayGotraDevak {
    final hasG = BiodataModel.isValuePresent(gotra);
    final hasD = BiodataModel.isValuePresent(devak);
    if (hasG && hasD) return '$gotra / $devak';
    if (hasG) return gotra;
    if (hasD) return devak;
    return '';
  }

  String get displayRashiNakshatra {
    final parts = <String>[];
    if (BiodataModel.isValuePresent(rashi)) parts.add(rashi);
    if (BiodataModel.isValuePresent(nakshatra)) {
      if (BiodataModel.isValuePresent(charan)) {
        parts.add('$nakshatra (Charan $charan)');
      } else {
        parts.add(nakshatra);
      }
    } else if (BiodataModel.isValuePresent(charan)) {
      parts.add('Charan $charan');
    }
    return parts.join(' • ');
  }

  String get displayManglikNadi {
    final parts = <String>[];
    if (BiodataModel.isValuePresent(manglik) && manglik.trim().toLowerCase() != "don't know") {
      parts.add('Manglik: $manglik');
    }
    if (BiodataModel.isValuePresent(nadi)) {
      parts.add('Nadi: $nadi');
    }
    return parts.join(' • ');
  }

  String get displayGanKuldaivat {
    final parts = <String>[];
    if (BiodataModel.isValuePresent(gan)) parts.add('Gan: $gan');
    if (BiodataModel.isValuePresent(kuldaivat)) parts.add('Kuldaivat: $kuldaivat');
    return parts.join(' • ');
  }

  bool get hasExtraPhotos =>
      (extraPhoto1Path != null && extraPhoto1Path!.trim().isNotEmpty) ||
      (extraPhoto2Path != null && extraPhoto2Path!.trim().isNotEmpty);

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
    String? devak,
    String? rashi,
    String? nakshatra,
    String? charan,
    String? gan,
    String? nadi,
    String? manglik,
    String? kuldaivat,
    String? profileImagePath,
    bool clearProfileImage = false,
    String? extraPhoto1Path,
    bool clearExtraPhoto1 = false,
    String? extraPhoto2Path,
    bool clearExtraPhoto2 = false,
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
      devak: devak ?? this.devak,
      rashi: rashi ?? this.rashi,
      nakshatra: nakshatra ?? this.nakshatra,
      charan: charan ?? this.charan,
      gan: gan ?? this.gan,
      nadi: nadi ?? this.nadi,
      manglik: manglik ?? this.manglik,
      kuldaivat: kuldaivat ?? this.kuldaivat,
      profileImagePath: clearProfileImage ? null : (profileImagePath ?? this.profileImagePath),
      extraPhoto1Path: clearExtraPhoto1 ? null : (extraPhoto1Path ?? this.extraPhoto1Path),
      extraPhoto2Path: clearExtraPhoto2 ? null : (extraPhoto2Path ?? this.extraPhoto2Path),
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
      'devak': devak,
      'rashi': rashi,
      'nakshatra': nakshatra,
      'charan': charan,
      'gan': gan,
      'nadi': nadi,
      'manglik': manglik,
      'kuldaivat': kuldaivat,
      'profileImagePath': profileImagePath,
      'extraPhoto1Path': extraPhoto1Path,
      'extraPhoto2Path': extraPhoto2Path,
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
      devak: map['devak'] ?? '',
      rashi: map['rashi'] ?? '',
      nakshatra: map['nakshatra'] ?? '',
      charan: map['charan'] ?? '',
      gan: map['gan'] ?? '',
      nadi: map['nadi'] ?? '',
      manglik: map['manglik'] ?? 'No',
      kuldaivat: map['kuldaivat'] ?? '',
      profileImagePath: map['profileImagePath'],
      extraPhoto1Path: map['extraPhoto1Path'],
      extraPhoto2Path: map['extraPhoto2Path'],
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
      devak: 'Panchpalvi',
      rashi: 'Simha (Leo)',
      nakshatra: 'Magha',
      charan: '1',
      gan: 'Rakshas',
      nadi: 'Antya',
      manglik: 'No',
      kuldaivat: 'Khandoba',
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
