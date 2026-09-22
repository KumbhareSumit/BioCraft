import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/models/biodata_model.dart';
import '../logic/biodata_provider.dart';

class BiodataFormScreen extends StatefulWidget {
  const BiodataFormScreen({super.key});

  @override
  State<BiodataFormScreen> createState() => _BiodataFormScreenState();
}

class _BiodataFormScreenState extends State<BiodataFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _tobController;
  late TextEditingController _pobController;
  late TextEditingController _heightController;
  late TextEditingController _complexionController;
  late TextEditingController _bloodGroupController;
  late TextEditingController _motherTongueController;
  late TextEditingController _religionHeadingController;
  late TextEditingController _religionController;
  late TextEditingController _casteController;
  late TextEditingController _subCasteController;
  late TextEditingController _gotraController;
  late TextEditingController _rashiController;
  late TextEditingController _nakshatraController;

  late TextEditingController _educationController;
  late TextEditingController _eduDetailsController;
  late TextEditingController _occupationController;
  late TextEditingController _companyController;
  late TextEditingController _incomeController;
  late TextEditingController _locationController;

  late TextEditingController _fatherNameController;
  late TextEditingController _fatherOccController;
  late TextEditingController _motherNameController;
  late TextEditingController _motherOccController;
  late TextEditingController _brothersCountController;
  late TextEditingController _brothersDetailsController;
  late TextEditingController _sistersCountController;
  late TextEditingController _sistersDetailsController;
  late TextEditingController _maternalUncleController;

  late TextEditingController _contactPersonController;
  late TextEditingController _contactNumController;
  late TextEditingController _altNumController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _nativePlaceController;
  late TextEditingController _expectationsController;

  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Never Married';
  String _selectedManglik = 'No';
  String _selectedFamilyType = 'Nuclear';
  String _selectedFamilyValues = 'Moderate';
  String? _loadedBiodataId;

  @override
  void initState() {
    super.initState();
    final bio = context.read<BiodataProvider>().currentBiodata;
    _loadedBiodataId = bio.id;
    _initControllers(bio);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bio = context.watch<BiodataProvider>().currentBiodata;
    if (_loadedBiodataId != bio.id) {
      _loadedBiodataId = bio.id;
      _populateControllers(bio);
    }
  }

  void _initControllers(BiodataModel bio) {
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _tobController = TextEditingController();
    _pobController = TextEditingController();
    _heightController = TextEditingController();
    _complexionController = TextEditingController();
    _bloodGroupController = TextEditingController();
    _motherTongueController = TextEditingController();
    _religionHeadingController = TextEditingController();
    _religionController = TextEditingController();
    _casteController = TextEditingController();
    _subCasteController = TextEditingController();
    _gotraController = TextEditingController();
    _rashiController = TextEditingController();
    _nakshatraController = TextEditingController();

    _educationController = TextEditingController();
    _eduDetailsController = TextEditingController();
    _occupationController = TextEditingController();
    _companyController = TextEditingController();
    _incomeController = TextEditingController();
    _locationController = TextEditingController();

    _fatherNameController = TextEditingController();
    _fatherOccController = TextEditingController();
    _motherNameController = TextEditingController();
    _motherOccController = TextEditingController();
    _brothersCountController = TextEditingController();
    _brothersDetailsController = TextEditingController();
    _sistersCountController = TextEditingController();
    _sistersDetailsController = TextEditingController();
    _maternalUncleController = TextEditingController();

    _contactPersonController = TextEditingController();
    _contactNumController = TextEditingController();
    _altNumController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _nativePlaceController = TextEditingController();
    _expectationsController = TextEditingController();

    _populateControllers(bio);
  }

  void _populateControllers(BiodataModel bio) {
    _nameController.text = bio.fullName;
    _dobController.text = bio.dateOfBirth;
    _tobController.text = bio.timeOfBirth;
    _pobController.text = bio.placeOfBirth;
    _heightController.text = bio.height;
    _complexionController.text = bio.complexion;
    _bloodGroupController.text = bio.bloodGroup;
    _motherTongueController.text = bio.motherTongue;
    _religionHeadingController.text = bio.religionHeading;
    _religionController.text = bio.religion;
    _casteController.text = bio.caste;
    _subCasteController.text = bio.subCaste;
    _gotraController.text = bio.gotra;
    _rashiController.text = bio.rashi;
    _nakshatraController.text = bio.nakshatra;

    _educationController.text = bio.highestEducation;
    _eduDetailsController.text = bio.educationDetails;
    _occupationController.text = bio.occupation;
    _companyController.text = bio.companyName;
    _incomeController.text = bio.annualIncome;
    _locationController.text = bio.workLocation;

    _fatherNameController.text = bio.fatherName;
    _fatherOccController.text = bio.fatherOccupation;
    _motherNameController.text = bio.motherName;
    _motherOccController.text = bio.motherOccupation;
    _brothersCountController.text = bio.brothersCount;
    _brothersDetailsController.text = bio.brothersDetails;
    _sistersCountController.text = bio.sistersCount;
    _sistersDetailsController.text = bio.sistersDetails;
    _maternalUncleController.text = bio.maternalUncleDetails;

    _contactPersonController.text = bio.contactPerson;
    _contactNumController.text = bio.contactNumber;
    _altNumController.text = bio.alternateNumber;
    _emailController.text = bio.email;
    _addressController.text = bio.residentialAddress;
    _nativePlaceController.text = bio.nativePlace;
    _expectationsController.text = bio.expectations;

    _selectedGender = bio.gender.isNotEmpty ? bio.gender : 'Male';
    _selectedMaritalStatus = bio.maritalStatus.isNotEmpty ? bio.maritalStatus : 'Never Married';
    _selectedManglik = bio.manglik.isNotEmpty ? bio.manglik : 'No';
    _selectedFamilyType = bio.familyType.isNotEmpty ? bio.familyType : 'Nuclear';
    _selectedFamilyValues = bio.familyValues.isNotEmpty ? bio.familyValues : 'Moderate';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _tobController.dispose();
    _pobController.dispose();
    _heightController.dispose();
    _complexionController.dispose();
    _bloodGroupController.dispose();
    _motherTongueController.dispose();
    _religionHeadingController.dispose();
    _religionController.dispose();
    _casteController.dispose();
    _subCasteController.dispose();
    _gotraController.dispose();
    _rashiController.dispose();
    _nakshatraController.dispose();
    _educationController.dispose();
    _eduDetailsController.dispose();
    _occupationController.dispose();
    _companyController.dispose();
    _incomeController.dispose();
    _locationController.dispose();
    _fatherNameController.dispose();
    _fatherOccController.dispose();
    _motherNameController.dispose();
    _motherOccController.dispose();
    _brothersCountController.dispose();
    _brothersDetailsController.dispose();
    _sistersCountController.dispose();
    _sistersDetailsController.dispose();
    _maternalUncleController.dispose();
    _contactPersonController.dispose();
    _contactNumController.dispose();
    _altNumController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _nativePlaceController.dispose();
    _expectationsController.dispose();
    super.dispose();
  }

  void _syncToProvider() {
    final provider = context.read<BiodataProvider>();
    final current = provider.currentBiodata;
    provider.updateBiodata(
      current.copyWith(
        fullName: _nameController.text.trim(),
        gender: _selectedGender,
        dateOfBirth: _dobController.text.trim(),
        timeOfBirth: _tobController.text.trim(),
        placeOfBirth: _pobController.text.trim(),
        height: _heightController.text.trim(),
        complexion: _complexionController.text.trim(),
        bloodGroup: _bloodGroupController.text.trim(),
        maritalStatus: _selectedMaritalStatus,
        motherTongue: _motherTongueController.text.trim(),
        religionHeading: _religionHeadingController.text.trim(),
        religion: _religionController.text.trim(),
        caste: _casteController.text.trim(),
        subCaste: _subCasteController.text.trim(),
        gotra: _gotraController.text.trim(),
        rashi: _rashiController.text.trim(),
        nakshatra: _nakshatraController.text.trim(),
        manglik: _selectedManglik,
        highestEducation: _educationController.text.trim(),
        educationDetails: _eduDetailsController.text.trim(),
        occupation: _occupationController.text.trim(),
        companyName: _companyController.text.trim(),
        annualIncome: _incomeController.text.trim(),
        workLocation: _locationController.text.trim(),
        fatherName: _fatherNameController.text.trim(),
        fatherOccupation: _fatherOccController.text.trim(),
        motherName: _motherNameController.text.trim(),
        motherOccupation: _motherOccController.text.trim(),
        brothersCount: _brothersCountController.text.trim(),
        brothersDetails: _brothersDetailsController.text.trim(),
        sistersCount: _sistersCountController.text.trim(),
        sistersDetails: _sistersDetailsController.text.trim(),
        familyType: _selectedFamilyType,
        familyValues: _selectedFamilyValues,
        maternalUncleDetails: _maternalUncleController.text.trim(),
        contactPerson: _contactPersonController.text.trim(),
        contactNumber: _contactNumController.text.trim(),
        alternateNumber: _altNumController.text.trim(),
        email: _emailController.text.trim(),
        residentialAddress: _addressController.text.trim(),
        nativePlace: _nativePlaceController.text.trim(),
        expectations: _expectationsController.text.trim(),
      ),
    );
  }

  void _fillSampleData() {
    setState(() {
      _nameController.text = 'Aarav Devendra Sharma';
      _selectedGender = 'Male';
      _dobController.text = '15 May 1996';
      _tobController.text = '08:45 AM';
      _pobController.text = 'Pune, Maharashtra';
      _heightController.text = "5' 11\"";
      _complexionController.text = 'Fair';
      _bloodGroupController.text = 'O+';
      _selectedMaritalStatus = 'Never Married';
      _motherTongueController.text = 'Hindi / Marathi';
      _religionHeadingController.text = '॥ श्री गणेशाय नमः ॥';
      _religionController.text = 'Hindu';
      _casteController.text = 'Brahmin';
      _subCasteController.text = 'Gour';
      _gotraController.text = 'Kaushik';
      _rashiController.text = 'Taurus (Vrishabha)';
      _nakshatraController.text = 'Rohini';
      _selectedManglik = 'No';

      _educationController.text = 'B.Tech in Computer Science';
      _eduDetailsController.text = 'IIT Bombay (Batch of 2018)';
      _occupationController.text = 'Senior Software Engineer';
      _companyController.text = 'Microsoft';
      _incomeController.text = '₹ 38 LPA';
      _locationController.text = 'Bengaluru, India';

      _fatherNameController.text = 'Devendra Sharma';
      _fatherOccController.text = 'Senior Manager (Retd. SBI)';
      _motherNameController.text = 'Sunita Sharma';
      _motherOccController.text = 'Homemaker';
      _brothersCountController.text = '1';
      _brothersDetailsController.text = 'Younger Brother (Studying MBA)';
      _sistersCountController.text = '0';
      _sistersDetailsController.text = 'None';
      _selectedFamilyType = 'Nuclear';
      _selectedFamilyValues = 'Moderate';
      _maternalUncleController.text = 'Dr. Rajesh Pandey (Nagpur)';

      _contactPersonController.text = 'Devendra Sharma (Father)';
      _contactNumController.text = '+91 98765 43210';
      _altNumController.text = '+91 98231 23456';
      _emailController.text = 'aarav.sharma@example.com';
      _addressController.text = 'A-402, Royal Palms Society, Baner, Pune - 411045';
      _nativePlaceController.text = 'Indore, Madhya Pradesh';
      _expectationsController.text =
          'Looking for a well-educated, cultured, and family-oriented partner with good communication and mutual respect.';
    });
    _syncToProvider();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sample data filled successfully! Tap Preview to view design.'),
        backgroundColor: AppColors.secondaryDark,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 26, 1, 1),
      firstDate: DateTime(1960),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormatters.formatDisplayDate(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _tobController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata Creator',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: _fillSampleData,
            icon: const Icon(Icons.auto_awesome, color: AppColors.secondaryDark, size: 18),
            label: Text(
              'Auto Fill',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Live Preview Studio',
            icon: const Icon(Icons.visibility, color: AppColors.primary),
            onPressed: () {
              _syncToProvider();
              context.push('/preview-biodata');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isDesktop ? 900 : double.infinity),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildStepHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: _buildCurrentStepContent(),
                  ),
                ),
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader() {
    final steps = [
      'Personal',
      'Astrology',
      'Career',
      'Family',
      'Contact',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(bottom: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isSelected = index == _currentStep;
          final isCompleted = index < _currentStep;

          return Expanded(
            child: InkWell(
              onTap: () {
                _syncToProvider();
                setState(() => _currentStep = index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: isSelected
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.surfaceVariant,
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Personal();
      case 1:
        return _buildStep2Astrology();
      case 2:
        return _buildStep3Career();
      case 3:
        return _buildStep4Family();
      case 4:
        return _buildStep5Contact();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Personal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Details', Icons.person_outline),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _nameController,
          label: 'Full Name *',
          hint: 'e.g. Aarav Sharma',
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Gender',
                value: _selectedGender,
                items: ['Male', 'Female', 'Other'],
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _dobController,
                label: 'Date of Birth',
                hint: 'DD MMM YYYY',
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                readOnly: true,
                onTap: _pickDate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _tobController,
                label: 'Time of Birth',
                hint: 'e.g. 08:30 AM',
                prefixIcon: const Icon(Icons.access_time),
                readOnly: true,
                onTap: _pickTime,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _pobController,
                label: 'Place of Birth',
                hint: 'e.g. Pune, MH',
                prefixIcon: const Icon(Icons.location_city_outlined),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _heightController,
                label: 'Height',
                hint: "e.g. 5' 10\"",
                prefixIcon: const Icon(Icons.height),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _complexionController,
                label: 'Complexion',
                hint: 'e.g. Fair / Wheatish',
                prefixIcon: const Icon(Icons.face_retouching_natural),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _bloodGroupController,
                label: 'Blood Group',
                hint: 'e.g. O+, B+, A+',
                prefixIcon: const Icon(Icons.bloodtype_outlined),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildDropdown(
                label: 'Marital Status',
                value: _selectedMaritalStatus,
                items: ['Never Married', 'Divorced', 'Widowed', 'Awaiting Divorce'],
                onChanged: (val) => setState(() => _selectedMaritalStatus = val!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _motherTongueController,
          label: 'Mother Tongue',
          hint: 'e.g. Hindi, Marathi, Gujarati, Bengali',
          prefixIcon: const Icon(Icons.translate),
        ),
      ],
    );
  }

  Widget _buildStep2Astrology() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Religion & Horoscope', Icons.auto_awesome_outlined),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _religionHeadingController,
          label: 'Top Header Symbol / Mantra',
          hint: 'e.g. ॥ श्री गणेशाय नमः ॥ or ੴ ਸਤਿਗੁਰ ਪ੍ਰਸਾਦਿ',
          prefixIcon: const Icon(Icons.flare),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _religionController,
                label: 'Religion',
                hint: 'e.g. Hindu / Jain / Sikh',
                prefixIcon: const Icon(Icons.temple_hindu_outlined),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _casteController,
                label: 'Caste',
                hint: 'e.g. Brahmin, Maratha',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _subCasteController,
                label: 'Sub-Caste',
                hint: 'e.g. Gour, Deshastha',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _gotraController,
                label: 'Gotra',
                hint: 'e.g. Kaushik, Kashyap',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _rashiController,
                label: 'Rashi (Zodiac)',
                hint: 'e.g. Vrishabha (Taurus)',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _nakshatraController,
                label: 'Nakshatra',
                hint: 'e.g. Rohini, Ashwini',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _buildDropdown(
          label: 'Manglik Status',
          value: _selectedManglik,
          items: ['No', 'Yes', 'Anshik (Partial)', 'Don\'t Know'],
          onChanged: (val) => setState(() => _selectedManglik = val!),
        ),
      ],
    );
  }

  Widget _buildStep3Career() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education & Profession', Icons.work_outline),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _educationController,
          label: 'Highest Qualification',
          hint: 'e.g. B.Tech / MBA / MBBS / CA',
          prefixIcon: const Icon(Icons.school_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _eduDetailsController,
          label: 'College / University Details',
          hint: 'e.g. IIT Bombay / Delhi University',
          prefixIcon: const Icon(Icons.account_balance_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _occupationController,
          label: 'Occupation / Job Title',
          hint: 'e.g. Senior Software Engineer / Doctor / Business Owner',
          prefixIcon: const Icon(Icons.business_center_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _companyController,
          label: 'Company / Organization Name',
          hint: 'e.g. Microsoft / Self Employed',
          prefixIcon: const Icon(Icons.apartment_outlined),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _incomeController,
                label: 'Annual Income',
                hint: 'e.g. ₹ 25-30 LPA',
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _locationController,
                label: 'Work Location',
                hint: 'e.g. Bengaluru / Pune',
                prefixIcon: const Icon(Icons.pin_drop_outlined),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep4Family() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Family Background', Icons.family_restroom_outlined),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _fatherNameController,
          label: "Father's Name",
          hint: 'e.g. Shri Devendra Sharma',
          prefixIcon: const Icon(Icons.person_outline),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _fatherOccController,
          label: "Father's Occupation",
          hint: 'e.g. Businessman / Govt. Officer (Retd.)',
          prefixIcon: const Icon(Icons.work_outline),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _motherNameController,
          label: "Mother's Name",
          hint: 'e.g. Smt. Sunita Sharma',
          prefixIcon: const Icon(Icons.person_outline),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _motherOccController,
          label: "Mother's Occupation",
          hint: 'e.g. Homemaker / Teacher',
          prefixIcon: const Icon(Icons.work_outline),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _brothersCountController,
                label: 'Brothers',
                hint: 'e.g. 1 (Married)',
                prefixIcon: const Icon(Icons.people_outline),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _sistersCountController,
                label: 'Sisters',
                hint: 'e.g. 0',
                prefixIcon: const Icon(Icons.people_outline),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Family Type',
                value: _selectedFamilyType,
                items: ['Nuclear', 'Joint'],
                onChanged: (val) => setState(() => _selectedFamilyType = val!),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildDropdown(
                label: 'Family Values',
                value: _selectedFamilyValues,
                items: ['Traditional', 'Moderate', 'Liberal'],
                onChanged: (val) => setState(() => _selectedFamilyValues = val!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _maternalUncleController,
          label: 'Maternal Uncle / Mama Details (Optional)',
          hint: 'e.g. Shri Rajesh Pandey (Nagpur)',
          prefixIcon: const Icon(Icons.handshake_outlined),
        ),
      ],
    );
  }

  Widget _buildStep5Contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact & Expectations', Icons.contact_phone_outlined),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _contactPersonController,
          label: 'Primary Contact Person',
          hint: 'e.g. Devendra Sharma (Father)',
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _contactNumController,
                label: 'Contact Number',
                hint: 'e.g. +91 98765 43210',
                prefixIcon: const Icon(Icons.phone_outlined),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _altNumController,
                label: 'Alternate Number',
                hint: 'e.g. +91 98231 23456',
                prefixIcon: const Icon(Icons.phone_iphone_outlined),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _emailController,
          label: 'Email Address',
          hint: 'e.g. contact@example.com',
          prefixIcon: const Icon(Icons.email_outlined),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _addressController,
          label: 'Residential Address',
          hint: 'e.g. Flat 402, Royal Residency, Pune - 411045',
          prefixIcon: const Icon(Icons.home_outlined),
          maxLines: 2,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _nativePlaceController,
          label: 'Native Place / Hometown',
          hint: 'e.g. Indore, Madhya Pradesh',
          prefixIcon: const Icon(Icons.place_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _expectationsController,
          label: 'Partner Expectations (Optional)',
          hint: 'e.g. Looking for an educated, cultured partner with mutual respect...',
          prefixIcon: const Icon(Icons.favorite_border),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: items.contains(value) ? value : items.first,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.8)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: AppButton(
                text: 'Previous',
                type: AppButtonType.outline,
                onPressed: () {
                  _syncToProvider();
                  setState(() => _currentStep--);
                },
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              text: _currentStep < 4 ? 'Next Step' : 'Preview Biodata',
              icon: _currentStep < 4 ? Icons.arrow_forward : Icons.remove_red_eye_outlined,
              onPressed: () {
                _syncToProvider();
                if (_currentStep < 4) {
                  setState(() => _currentStep++);
                } else {
                  context.push('/preview-biodata');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
