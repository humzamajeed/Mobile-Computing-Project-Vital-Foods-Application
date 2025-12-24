import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'core/firebase/firebase_config.dart';
import 'core/di/injection_container.dart';
import 'core/storage/shared_preferences_service.dart';
import 'core/services/database_init_service.dart';
import 'domain/entities/user.dart';
import 'presentation/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseConfig.initialize();

  // Initialize SharedPreferences
  await SharedPreferencesService.init();

  // Initialize database collections
  final dbInitService = DatabaseInitService();
  await dbInitService.initializeCollections();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize dependency injection
  final container = InjectionContainer();

  // Get initial user if authenticated
  final authRepository = container.authRepository;
  final initialUser = await authRepository.getCurrentUser();

  runApp(MyApp(container: container, initialUser: initialUser));
}

class MyApp extends StatefulWidget {
  final InjectionContainer container;
  final User? initialUser;

  const MyApp({super.key, required this.container, this.initialUser});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Set initial user in auth provider
    if (widget.initialUser != null) {
      widget.container.authProvider.setUser(widget.initialUser);
    }

    // Initialize locale
    widget.container.localeProvider.initializeLocale();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Clear database when app is closed/terminated
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      _clearDatabaseOnAppClose();
    }
  }

  Future<void> _clearDatabaseOnAppClose() async {
    try {
      debugPrint('🔄 App closing - clearing database...');
      await widget.container.databaseCleanupService.clearAllCollections();
      debugPrint('✅ Database cleared on app close');
    } catch (e) {
      debugPrint('❌ Error clearing database on app close: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.container.authProvider),
        ChangeNotifierProvider.value(value: widget.container.settingsProvider),
        ChangeNotifierProvider.value(value: widget.container.cartProvider),
        ChangeNotifierProvider.value(value: widget.container.favoriteProvider),
        ChangeNotifierProvider.value(value: widget.container.orderProvider),
        ChangeNotifierProvider.value(value: widget.container.reviewProvider),
        ChangeNotifierProvider.value(value: widget.container.localeProvider),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Food Delivery App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('en', 'US'), // English
              Locale('fr', 'FR'), // French
              Locale('ar', 'SA'), // Arabic
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
