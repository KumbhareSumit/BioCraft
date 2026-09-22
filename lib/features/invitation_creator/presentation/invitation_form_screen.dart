import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/models/invitation_model.dart';
import '../logic/invitation_provider.dart';

class InvitationFormScreen extends StatefulWidget {
  const InvitationFormScreen({super.key});

  @override
  State<InvitationFormScreen> createState() => _InvitationFormScreenState();
}

class _InvitationFormScreenState extends State<InvitationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  late TextEditingController _eventTypeController;
  late TextEditingController _titleHeadingController;
  late TextEditingController _hostNamesController;
  late TextEditingController _eventTitleController;
  late TextEditingController _brideNameController;
  late TextEditingController _brideParentsController;
  late TextEditingController _groomNameController;
  late TextEditingController _groomParentsController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventTimeController;
  late TextEditingController _venueNameController;
  late TextEditingController _venueAddressController;
  late TextEditingController _rsvpDetailsController;
  late TextEditingController _dressCodeController;
  late TextEditingController _specialNoteController;

  String? _loadedInvitationId;

  final List<String> _eventTypes = [
    'Wedding Invitation',
    'Engagement Ceremony',
    'Birthday Party',
    'Housewarming (Griha Pravesh)',
    'Anniversary Celebration',
    'Baby Shower / Naming Ceremony',
    'Business Grand Opening',
    'Dinner & Party Gathering',
  ];

  @override
  void initState() {
    super.initState();
    final inv = context.read<InvitationProvider>().currentInvitation;
    _loadedInvitationId = inv.id;
    _initControllers(inv);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final inv = context.watch<InvitationProvider>().currentInvitation;
    if (_loadedInvitationId != inv.id) {
      _loadedInvitationId = inv.id;
      _populateControllers(inv);
    }
  }

  void _initControllers(InvitationModel inv) {
    _eventTypeController = TextEditingController();
    _titleHeadingController = TextEditingController();
    _hostNamesController = TextEditingController();
    _eventTitleController = TextEditingController();
    _brideNameController = TextEditingController();
    _brideParentsController = TextEditingController();
    _groomNameController = TextEditingController();
    _groomParentsController = TextEditingController();
    _eventDateController = TextEditingController();
    _eventTimeController = TextEditingController();
    _venueNameController = TextEditingController();
    _venueAddressController = TextEditingController();
    _rsvpDetailsController = TextEditingController();
    _dressCodeController = TextEditingController();
    _specialNoteController = TextEditingController();

    _populateControllers(inv);
  }

  void _populateControllers(InvitationModel inv) {
    _eventTypeController.text = inv.eventType;
    _titleHeadingController.text = inv.titleHeading;
    _hostNamesController.text = inv.hostNames;
    _eventTitleController.text = inv.eventTitle;
    _brideNameController.text = inv.brideName;
    _brideParentsController.text = inv.brideParents;
    _groomNameController.text = inv.groomName;
    _groomParentsController.text = inv.groomParents;
    _eventDateController.text = inv.eventDate;
    _eventTimeController.text = inv.eventTime;
    _venueNameController.text = inv.venueName;
    _venueAddressController.text = inv.venueAddress;
    _rsvpDetailsController.text = inv.rsvpDetails;
    _dressCodeController.text = inv.dressCode;
    _specialNoteController.text = inv.specialNote;
  }

  @override
  void dispose() {
    _eventTypeController.dispose();
    _titleHeadingController.dispose();
    _hostNamesController.dispose();
    _eventTitleController.dispose();
    _brideNameController.dispose();
    _brideParentsController.dispose();
    _groomNameController.dispose();
    _groomParentsController.dispose();
    _eventDateController.dispose();
    _eventTimeController.dispose();
    _venueNameController.dispose();
    _venueAddressController.dispose();
    _rsvpDetailsController.dispose();
    _dressCodeController.dispose();
    _specialNoteController.dispose();
    super.dispose();
  }

  void _syncToProvider() {
    final provider = context.read<InvitationProvider>();
    final current = provider.currentInvitation;
    provider.updateInvitation(
      current.copyWith(
        eventType: _eventTypeController.text.trim(),
        titleHeading: _titleHeadingController.text.trim(),
        hostNames: _hostNamesController.text.trim(),
        eventTitle: _eventTitleController.text.trim(),
        brideName: _brideNameController.text.trim(),
        brideParents: _brideParentsController.text.trim(),
        groomName: _groomNameController.text.trim(),
        groomParents: _groomParentsController.text.trim(),
        eventDate: _eventDateController.text.trim(),
        eventTime: _eventTimeController.text.trim(),
        venueName: _venueNameController.text.trim(),
        venueAddress: _venueAddressController.text.trim(),
        rsvpDetails: _rsvpDetailsController.text.trim(),
        dressCode: _dressCodeController.text.trim(),
        specialNote: _specialNoteController.text.trim(),
      ),
    );
  }

  void _fillSample(String type) {
    final sample = InvitationModel.sample(type: type);
    setState(() {
      _populateControllers(sample);
    });
    _syncToProvider();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type sample filled! Tap Live Preview to view card.'),
        backgroundColor: AppColors.secondaryDark,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = DateFormatters.formatDisplayDate(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 30),
    );
    if (picked != null) {
      setState(() {
        _eventTimeController.text = '${picked.format(context)} Onwards';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invitation Card Studio',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.auto_awesome, color: AppColors.secondaryDark),
            tooltip: 'Auto-Fill Sample',
            onSelected: (val) => _fillSample(val),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Wedding', child: Text('💍 Wedding Sample')),
              const PopupMenuItem(value: 'Birthday', child: Text('🎂 Birthday Sample')),
              const PopupMenuItem(value: 'Housewarming', child: Text('🏡 Griha Pravesh Sample')),
            ],
          ),
          IconButton(
            tooltip: 'Live Preview Studio',
            icon: const Icon(Icons.visibility, color: AppColors.primary),
            onPressed: () {
              _syncToProvider();
              context.push('/preview-studio?category=invitation');
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
    final steps = ['Occasion', 'Hosts & Guests', 'Time & Venue', 'RSVP & Notes'];

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
        return _buildStep1Occasion();
      case 1:
        return _buildStep2People();
      case 2:
        return _buildStep3Venue();
      case 3:
        return _buildStep4RSVP();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Occasion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Select Event Occasion', Icons.celebration_outlined),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _eventTypes.contains(_eventTypeController.text)
              ? _eventTypeController.text
              : _eventTypes.first,
          decoration: const InputDecoration(
            labelText: 'Occasion Type',
            prefixIcon: Icon(Icons.stars),
          ),
          items: _eventTypes.map((type) {
            return DropdownMenuItem(value: type, child: Text(type, style: const TextStyle(fontSize: 14)));
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _eventTypeController.text = val;
                if (val.contains('Wedding')) {
                  _titleHeadingController.text = '॥ शुभ विवाह ॥';
                  _eventTitleController.text = 'Wedding Ceremony & Reception';
                } else if (val.contains('Birthday')) {
                  _titleHeadingController.text = '🎉 Let\'s Celebrate! 🎉';
                  _eventTitleController.text = 'Birthday Celebration';
                } else if (val.contains('Housewarming')) {
                  _titleHeadingController.text = '॥ ॐ श्री गणेशाय नमः ॥';
                  _eventTitleController.text = 'Griha Pravesh & Vastu Pooja';
                } else {
                  _titleHeadingController.text = 'Cordially Invited';
                  _eventTitleController.text = val;
                }
              });
            }
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _titleHeadingController,
          label: 'Top Header Symbol / Mantra',
          hint: 'e.g. ॥ शुभ विवाह ॥ or 🎉 YOU\'RE INVITED 🎉',
          prefixIcon: const Icon(Icons.flare),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _eventTitleController,
          label: 'Event Title *',
          hint: 'e.g. Wedding Ceremony / 5th Birthday Party',
          prefixIcon: const Icon(Icons.title),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _hostNamesController,
          label: 'Host Invitation Message',
          hint: 'e.g. Mr. & Mrs. Rajesh Sharma cordially invite you to celebrate the wedding of...',
          prefixIcon: const Icon(Icons.mail_outline),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildStep2People() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Honoree & Host Details', Icons.people_outline),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _brideNameController,
          label: 'Bride / Primary Honoree Name *',
          hint: 'e.g. Ananya Verma / Aarav Deshmukh',
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _brideParentsController,
          label: 'Parentage / Details (Optional)',
          hint: 'e.g. D/o Mr. Suresh & Mrs. Sunita Verma',
          prefixIcon: const Icon(Icons.family_restroom),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _groomNameController,
          label: 'Groom / Partner Name (If applicable)',
          hint: 'e.g. Aarav Sharma',
          prefixIcon: const Icon(Icons.person_outline),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _groomParentsController,
          label: 'Groom Parents / Details (Optional)',
          hint: 'e.g. S/o Mr. Rajesh & Mrs. Geeta Sharma',
          prefixIcon: const Icon(Icons.family_restroom),
        ),
      ],
    );
  }

  Widget _buildStep3Venue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Date, Time & Venue', Icons.place_outlined),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _eventDateController,
                label: 'Event Date *',
                hint: 'e.g. Sunday, 12 Dec 2026',
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                readOnly: true,
                onTap: _pickDate,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CustomTextField(
                controller: _eventTimeController,
                label: 'Event Time',
                hint: 'e.g. 07:00 PM Onwards',
                prefixIcon: const Icon(Icons.access_time),
                readOnly: true,
                onTap: _pickTime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _venueNameController,
          label: 'Venue Name *',
          hint: 'e.g. The Grand Imperial Palace & Resort',
          prefixIcon: const Icon(Icons.apartment_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _venueAddressController,
          label: 'Venue Address',
          hint: 'e.g. Senapati Bapat Road, Shivajinagar, Pune - 411016',
          prefixIcon: const Icon(Icons.location_on_outlined),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildStep4RSVP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('RSVP & Additional Information', Icons.info_outline),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _rsvpDetailsController,
          label: 'RSVP Contacts',
          hint: 'e.g. Sharma Family | +91 98765 43210',
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _dressCodeController,
          label: 'Dress Code (Optional)',
          hint: 'e.g. Traditional / Festive / Smart Casual',
          prefixIcon: const Icon(Icons.checkroom_outlined),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: _specialNoteController,
          label: 'Special Wishes / Compliments',
          hint: 'e.g. With Best Compliments from Near & Dear Ones',
          prefixIcon: const Icon(Icons.favorite_outline),
          maxLines: 2,
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
              text: _currentStep < 3 ? 'Next Step' : 'Preview Invitation',
              icon: _currentStep < 3 ? Icons.arrow_forward : Icons.remove_red_eye_outlined,
              onPressed: () {
                _syncToProvider();
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  context.push('/preview-studio?category=invitation');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
