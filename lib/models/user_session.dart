class UserSession {
  const UserSession({
    required this.id,
    required this.displayName,
    required this.email,
    required this.phone,
    required this.isGuest,
    required this.isAuthenticated,
  });

  factory UserSession.guest() {
    return const UserSession(
      id: 'guest',
      displayName: 'Ramesh Kumar',
      email: 'ramesh.k@agrotech.in',
      phone: '+91 98765 43210',
      isGuest: true,
      isAuthenticated: true,
    );
  }

  factory UserSession.signedOut() {
    return const UserSession(
      id: 'signed-out',
      displayName: '',
      email: '',
      phone: '',
      isGuest: false,
      isAuthenticated: false,
    );
  }

  final String id;
  final String displayName;
  final String email;
  final String phone;
  final bool isGuest;
  final bool isAuthenticated;
}
