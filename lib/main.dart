import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_router.dart';
import 'app/theme/app_theme.dart';
import 'features/biodata_creator/logic/biodata_provider.dart';
import 'features/invitation_creator/logic/invitation_provider.dart';
import 'features/resume_creator/logic/resume_provider.dart';
import 'features/preview_studio/logic/preview_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BioCraftApp());
}

class BioCraftApp extends StatelessWidget {
  const BioCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BiodataProvider()),
        ChangeNotifierProvider(create: (_) => InvitationProvider()),
        ChangeNotifierProvider(create: (_) => ResumeProvider()),
        ChangeNotifierProvider(create: (_) => PreviewProvider()),
      ],
      child: MaterialApp.router(
        title: 'BioCraft - Biodata, Invitation & Resume Studio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
