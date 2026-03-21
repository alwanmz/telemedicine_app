import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/booking/presentation/pages/appointment_detail_page.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/booking/presentation/pages/booking_success_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/chat_room_page.dart';
import '../../features/doctors/presentation/pages/doctor_detail_page.dart';
import '../../features/doctors/presentation/pages/doctors_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/booking/models/appointment.dart';
import '../../features/prescriptions/models/pharmacy_order.dart';
import '../../features/prescriptions/models/prescription.dart';
import '../../features/prescriptions/presentation/pages/pharmacy_order_detail_page.dart';
import '../../features/prescriptions/presentation/pages/pharmacy_orders_page.dart';
import '../../features/prescriptions/presentation/pages/prescription_detail_page.dart';
import '../../features/prescriptions/presentation/pages/prescriptions_page.dart';
import '../../features/prescriptions/presentation/pages/redeem_medicine_page.dart';
import '../../features/profile/models/user_address.dart';
import '../../features/profile/models/family_member.dart';
import '../../features/profile/presentation/pages/address_form_page.dart';
import '../../features/profile/presentation/pages/address_list_page.dart';
import '../../features/profile/presentation/pages/family_member_form_page.dart';
import '../../features/profile/presentation/pages/family_members_page.dart';
import '../../features/profile/presentation/pages/help_page.dart';
import '../../features/profile/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/payment_methods_page.dart';
import '../../features/profile/presentation/pages/personal_info_page.dart';
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
        final appointment = state.extra as Appointment;
        return BookingSuccessPage(appointment: appointment);
      },
    ),
    GoRoute(
      path: '/appointment-detail',
      builder: (context, state) {
        final appointmentId = state.extra as String;
        return AppointmentDetailPage(appointmentId: appointmentId);
      },
    ),
    GoRoute(
      path: '/chat-room',
      builder: (context, state) {
        final session = state.extra as Map<String, dynamic>;
        return ChatRoomPage(session: session);
      },
    ),
    GoRoute(
      path: '/prescriptions',
      builder: (context, state) => const PrescriptionsPage(),
    ),
    GoRoute(
      path: '/prescription-detail',
      builder: (context, state) {
        final prescription = state.extra as Prescription;
        return PrescriptionDetailPage(prescription: prescription);
      },
    ),
    GoRoute(
      path: '/redeem-medicine',
      builder: (context, state) {
        final prescription = state.extra as Prescription;
        return RedeemMedicinePage(prescription: prescription);
      },
    ),
    GoRoute(
      path: '/pharmacy-orders',
      builder: (context, state) => const PharmacyOrdersPage(),
    ),
    GoRoute(
      path: '/pharmacy-order-detail',
      builder: (context, state) {
        final order = state.extra as PharmacyOrder;
        return PharmacyOrderDetailPage(order: order);
      },
    ),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const AddressListPage(),
    ),
    GoRoute(
      path: '/address-form',
      builder: (context, state) {
        final address = state.extra as UserAddress?;
        return AddressFormPage(address: address);
      },
    ),
    GoRoute(
      path: '/payment-methods',
      builder: (context, state) => const PaymentMethodsPage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      path: '/personal-info',
      builder: (context, state) => const PersonalInfoPage(),
    ),
    GoRoute(
      path: '/family-members',
      builder: (context, state) => const FamilyMembersPage(),
    ),
    GoRoute(
      path: '/family-member-form',
      builder: (context, state) {
        final member = state.extra as FamilyMember?;
        return FamilyMemberFormPage(member: member);
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
