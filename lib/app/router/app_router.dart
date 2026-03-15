import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/booking/presentation/pages/appointment_detail_page.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/booking/presentation/pages/booking_success_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/doctors/presentation/pages/doctor_detail_page.dart';
import '../../features/doctors/presentation/pages/doctors_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../shared/presentation/pages/main_shell_page.dart';
import '../../features/booking/presentation/pages/appointments_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/splash'),
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/doctor-detail',
      builder: (context, state) {
        final doctor = state.extra as Map<String, dynamic>;
        return DoctorDetailPage(doctor: doctor);
      },
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) {
        final doctor = state.extra as Map<String, dynamic>;
        return BookingPage(doctor: doctor);
      },
    ),
    GoRoute(
      path: '/booking-success',
      builder: (context, state) {
        final appointment = state.extra as Map<String, dynamic>;
        return BookingSuccessPage(appointment: appointment);
      },
    ),
    GoRoute(
      path: '/appointment-detail',
      builder: (context, state) {
        final appointment = state.extra as Map<String, dynamic>;
        return AppointmentDetailPage(appointment: appointment);
      },
    ),
    GoRoute(
      path: '/doctor-detail-list',
      builder: (context, state) => const DoctorsPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/appointments',
              builder: (context, state) => const AppointmentsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
