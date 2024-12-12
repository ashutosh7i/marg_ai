import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:margai_flutter/screens/splash/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'services/auth_service.dart';
import 'providers/language_provider.dart';
import 'providers/accessibility_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:margai_flutter/screens/main_layout.dart';
import 'package:margai_flutter/screens/user/create_profile_screen.dart'; // You'll need to create this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final authService = AuthService(prefs);
  final languageProvider = LanguageProvider(prefs);
  final accessibilityProvider = AccessibilityProvider(prefs);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: authService),
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider(create: (_) => accessibilityProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final accessibilityProvider = context.watch<AccessibilityProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MargAI',
      locale: languageProvider.currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hi'), // Hindi
        Locale('mr'), // Marathi
        Locale('or'), // Odia
        Locale('bg'), // Bengali
        Locale('gu'), // Gujarati
        Locale('kn'), // Kannada
        Locale('ml'), // Malayalam
        Locale('as'),
        Locale('ne'), // Nepali
        Locale('pa'),
        Locale('ta'), // Tamil
        Locale('te'), // Telugu
      ],
      theme: accessibilityProvider.getTheme(
        context,
        ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          // Default text theme with base sizes
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 96),
            displayMedium: TextStyle(fontSize: 60),
            displaySmall: TextStyle(fontSize: 48),
            headlineMedium: TextStyle(fontSize: 34),
            headlineSmall: TextStyle(fontSize: 24),
            titleLarge: TextStyle(fontSize: 20),
            titleMedium: TextStyle(fontSize: 16),
            titleSmall: TextStyle(fontSize: 14),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12),
            labelLarge: TextStyle(fontSize: 14),
            labelMedium: TextStyle(fontSize: 12),
            labelSmall: TextStyle(fontSize: 11),
          ),
          // Large touch targets
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(88, 48),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
            ),
          ),
        ),
      ),
      // Screen reader support
      shortcuts: {
        ...WidgetsApp.defaultShortcuts,
        const SingleActivator(LogicalKeyboardKey.select):
            const ActivateIntent(),
      },
      // Semantic labels for screen readers
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            // We don't use MediaQuery for text scaling anymore as we handle it in the theme
            textScaleFactor: 1.0,
          ),
          child: AnimatedTheme(
            data: accessibilityProvider.getTheme(context, Theme.of(context)),
            duration: accessibilityProvider.getAnimationDuration(),
            child: Semantics(
              container: true,
              child: child!,
            ),
          ),
        );
      },
      home: const InitialLoadingScreen(),
    );
  }
}

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key});

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final authService = context.read<AuthService>();

    try {
      final isLoggedIn = await authService.isLoggedIn();

      if (!mounted) return;

      if (isLoggedIn) {
        // User is logged in, check if profile is completed
        try {
          final userProfile = await authService.getProfile();
          // Check if required profile fields are filled
          final bool isProfileCompleted = userProfile['name'] != null &&
              userProfile['username'] != null &&
              userProfile['preferredLanguage'] != null;

          if (!mounted) return;

          if (isProfileCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateProfileScreen()),
            );
          }
        } catch (e) {
          // If there's an error fetching profile, assume profile needs to be created
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateProfileScreen()),
          );
        }
      } else {
        // User is not logged in, show onboarding
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } catch (e) {
      // Handle any errors during the auth check
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
