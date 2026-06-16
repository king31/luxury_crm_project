import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebasePerformance _performance = FirebasePerformance.instance;

  static FirebaseFirestore get firestore => _firestore;
  static FirebaseAuth get auth => _auth;
  static FirebaseStorage get storage => _storage;
  static FirebaseMessaging get messaging => _messaging;
  static FirebaseAnalytics get analytics => _analytics;
  static FirebaseCrashlytics get crashlytics => _crashlytics;
  static FirebasePerformance get performance => _performance;

  static Future<void> initialize() async {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    await _analytics.setAnalyticsCollectionEnabled(true);
    await _crashlytics.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = _crashlytics.recordFlutterFatalError;
  }

  static Future<String?> getFcmToken() async {
    return await _messaging.getToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}
