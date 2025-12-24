import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

/// Firebase configuration
/// Initializes Firebase for the app using generated firebase_options.dart
class FirebaseConfig {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      throw Exception('Firebase initialization failed: $e');
    }
  }
}
