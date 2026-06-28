import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/community/presentation/community_screen.dart';
import '../../features/diagnose/presentation/diagnose_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/legal/presentation/legal_screens.dart';
import '../../features/market/presentation/market_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../widgets/app_shell.dart';
import '../app_state.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      final isAuthRoute = state.uri.path == '/auth';
      final isPublicLegalRoute =
          state.uri.path == '/privacy' || state.uri.path == '/terms';
      if (!auth.isAuthenticated && !isAuthRoute && !isPublicLegalRoute) {
        return '/auth';
      }
      if (auth.isAuthenticated && isAuthRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/terms',
        builder: (context, state) => const TermsOfServiceScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/diagnose',
            builder: (context, state) => const DiagnoseScreen(),
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: '/market',
            builder: (context, state) => const MarketScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
