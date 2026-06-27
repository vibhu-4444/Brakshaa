import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_session.dart';

final authServiceProvider = Provider<AuthService>((ref) => LocalAuthService());

abstract class AuthService {
  Future<UserSession> signInAsGuest();
  Future<UserSession> signInWithEmail(String email, String password);
  Future<UserSession> signInWithGoogle();
  Future<UserSession> signInWithPhone(String phoneNumber);
  Future<UserSession> signOut();
}

class LocalAuthService implements AuthService {
  @override
  Future<UserSession> signInAsGuest() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return UserSession.guest();
  }

  @override
  Future<UserSession> signInWithEmail(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return UserSession(
      id: 'email-user',
      displayName: 'Ramesh Kumar',
      email: email.isEmpty ? 'ramesh.k@agrotech.in' : email,
      phone: '+91 98765 43210',
      isGuest: false,
      isAuthenticated: true,
    );
  }

  @override
  Future<UserSession> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const UserSession(
      id: 'google-user',
      displayName: 'Ramesh Kumar',
      email: 'ramesh.k@agrotech.in',
      phone: '+91 98765 43210',
      isGuest: false,
      isAuthenticated: true,
    );
  }

  @override
  Future<UserSession> signInWithPhone(String phoneNumber) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return UserSession(
      id: 'phone-user',
      displayName: 'Ramesh Kumar',
      email: 'ramesh.k@agrotech.in',
      phone: phoneNumber.isEmpty ? '+91 98765 43210' : phoneNumber,
      isGuest: false,
      isAuthenticated: true,
    );
  }

  @override
  Future<UserSession> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return UserSession.signedOut();
  }
}
