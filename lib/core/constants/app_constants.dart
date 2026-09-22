class AppConstants {
  static const String appName = 'BioCraft';
  static const String appTagline = 'Craft Premium Biodatas & Invitations with Elegance';
  static const String appVersion = '1.0.0';

  // Categories
  static const String categoryBiodata = 'Matrimonial Biodata';
  static const String categoryInvitation = 'Invitations & Cards';

  // Storage Keys
  static const String keySavedBiodatas = 'biocraft_saved_biodatas';
  static const String keySavedInvitations = 'biocraft_saved_invitations';
  static const String keyAppThemeMode = 'biocraft_theme_mode';

  // Religions & Symbols / Header Text
  static const List<String> religions = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Jain',
    'Buddhist',
    'General / Secular'
  ];

  static const Map<String, List<String>> religiousHeadings = {
    'Hindu': [
      '॥ श्री गणेशाय नमः ॥',
      '॥ श्री महालक्ष्मी प्रसन्न ॥',
      '॥ ॐ श्री विष्णवे नमः ॥',
      '॥ श्री कुलदेवतायै नमः ॥',
      '॥ ॐ नमः शिवाय ॥',
    ],
    'Muslim': [
      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'In the Name of Allah, the Most Beneficent, the Most Merciful',
      'Bismillahir Rahmanir Raheem',
    ],
    'Christian': [
      '✝ God Bless This Union ✝',
      '✝ By the Grace of God ✝',
      '✝ In God\'s Love ✝',
    ],
    'Sikh': [
      'ੴ ਸਤਿਗੁਰ ਪ੍ਰਸਾਦਿ ॥',
      'Ek Onkar Satnam',
      'ੴ Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh ੴ',
    ],
    'Jain': [
      '॥ ॐ श्री पार्श्वनाथाय नमः ॥',
      '॥ ॐ नमो जिणाणं ॥',
      '॥ जय जिनेन्द्र ॥',
    ],
    'Buddhist': [
      'Namo Buddhaya',
      'Buddham Saranam Gacchami',
    ],
    'General / Secular': [
      'Marriage Biodata',
      'Matrimonial Profile',
      'Curriculum Vitae',
    ],
  };

  // Marital Status
  static const List<String> maritalStatuses = [
    'Never Married',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
  ];

  // Complexion
  static const List<String> complexions = [
    'Fair',
    'Very Fair',
    'Wheatish',
    'Wheatish Medium',
    'Dusky',
  ];

  // Blood Groups
  static const List<String> bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Don\'t Know'
  ];

  // Rashi / Zodiac
  static const List<String> rashis = [
    'Mesh (Aries)',
    'Vrishabha (Taurus)',
    'Mithun (Gemini)',
    'Kark (Cancer)',
    'Simha (Leo)',
    'Kanya (Virgo)',
    'Tula (Libra)',
    'Vrischika (Scorpio)',
    'Dhanu (Sagittarius)',
    'Makar (Capricorn)',
    'Kumbha (Aquarius)',
    'Meen (Pisces)',
  ];

  // Manglik Status
  static const List<String> manglikOptions = [
    'No',
    'Yes',
    'Anshik (Partial)',
    'Don\'t Know',
  ];
}
