import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_service.dart';
import '../../../core/utils/logger.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth = FirebaseService.auth;
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  User? _currentUser;

  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
        if (doc.exists) {
          _currentUser = User.fromMap(doc.data()!);
          return _currentUser;
        }
      }
      return null;
    } catch (e) {
      AppLogger.error('Error getting current user', e);
      return null;
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) throw Exception('User not found');

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) throw Exception('User data not found');

      _currentUser = User.fromMap(doc.data()!);

      // Update last login
      await _firestore.collection('users').doc(user.uid).update({
        'lastLogin': DateTime.now().toIso8601String(),
      });

      // Save credentials for biometric
      await _secureStorage.write(key: 'email', value: email);
      await _secureStorage.write(key: 'password', value: password);

      AppLogger.info('User logged in: ${user.uid}');
      return _currentUser!;
    } catch (e) {
      AppLogger.error('Login error', e);
      throw Exception('فشل تسجيل الدخول: ${e.toString()}');
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) throw Exception('User creation failed');

      final newUser = User(
        id: user.uid,
        email: email,
        fullName: fullName,
        phone: phone,
        role: 'external_officer',
        department: 'external_relations',
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

      _currentUser = newUser;
      AppLogger.info('User registered: ${user.uid}');
      return newUser;
    } catch (e) {
      AppLogger.error('Registration error', e);
      throw Exception('فشل إنشاء الحساب: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _secureStorage.deleteAll();
    _currentUser = null;
    AppLogger.info('User logged out');
  }

  Future<void> updateUserProfile(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      _currentUser = user;
    } catch (e) {
      AppLogger.error('Update profile error', e);
      throw Exception('فشل تحديث الملف الشخصي');
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      AppLogger.error('Change password error', e);
      throw Exception('فشل تغيير كلمة المرور');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      AppLogger.error('Reset password error', e);
      throw Exception('فشل إرسال رابط إعادة التعيين');
    }
  }

  Future<bool> toggleBiometricAuth(bool enabled) async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) throw Exception('Biometric not available');

      if (enabled) {
        final authenticated = await _localAuth.authenticate(
          localizedReason: 'يرجى المصادقة لتفعيل الدخول البيومتري',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        return authenticated;
      }
      return true;
    } catch (e) {
      AppLogger.error('Biometric auth error', e);
      throw Exception('فشل تفعيل المصادقة البيومترية');
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) return false;

      return await _localAuth.authenticate(
        localizedReason: 'استخدم بصمة الإصبع أو Face ID للدخول',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      AppLogger.error('Biometric authentication error', e);
      return false;
    }
  }

  User? get currentUser => _currentUser;
}
