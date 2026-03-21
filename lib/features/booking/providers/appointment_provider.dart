import 'package:flutter_riverpod/legacy.dart';

import '../models/appointment.dart';

final appointmentsProvider =
    StateNotifierProvider<AppointmentsNotifier, List<Appointment>>(
      (ref) => AppointmentsNotifier(),
    );

class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  AppointmentsNotifier()
    : super([
        const Appointment(
          id: 'apt_1',
          doctorName: 'Dr. Amanda Putri, Sp.PD',
          specialization: 'Penyakit Dalam',
          hospital: 'RS Sehat Sentosa',
          date: 'Senin, 18 Maret 2026',
          time: '09:30',
          consultationType: 'Chat',
          complaint: 'Kontrol rutin tekanan darah.',
          paymentMethod: 'Tunai',
          paymentStatus: Appointment.paymentStatusUnpaid,
          invoiceNumber: 'INV-APT00001',
          totalPrice: 'Rp 80.000',
          status: Appointment.statusScheduled,
        ),
      ]);

  void addAppointment(Appointment appointment) {
    state = [appointment, ...state];
  }

  void cancelAppointment(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(status: Appointment.statusCancelled);
      }
      return item;
    }).toList();
  }

  void rescheduleAppointment({
    required String id,
    required String newDate,
    required String newTime,
  }) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(
          date: newDate,
          time: newTime,
          status: Appointment.statusRescheduled,
        );
      }
      return item;
    }).toList();
  }

  void markPaymentAsPaid(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(paymentStatus: Appointment.paymentStatusPaid);
      }
      return item;
    }).toList();
  }
}
