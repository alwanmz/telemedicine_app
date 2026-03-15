import 'package:flutter_riverpod/legacy.dart';

final appointmentsProvider =
    StateNotifierProvider<AppointmentsNotifier, List<Map<String, dynamic>>>(
      (ref) => AppointmentsNotifier(),
    );

class AppointmentsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  AppointmentsNotifier()
    : super([
        {
          'id': 'apt_1',
          'doctorName': 'Dr. Amanda Putri, Sp.PD',
          'specialization': 'Penyakit Dalam',
          'hospital': 'RS Sehat Sentosa',
          'date': 'Senin, 18 Maret 2026',
          'time': '09:30',
          'consultationType': 'Chat',
          'complaint': 'Kontrol rutin tekanan darah.',
          'totalPrice': 'Rp 80.000',
          'status': 'Terjadwal',
        },
      ]);

  void addAppointment(Map<String, dynamic> appointment) {
    state = [appointment, ...state];
  }

  void cancelAppointment(String id) {
    state = state.map((item) {
      if (item['id'] == id) {
        return {...item, 'status': 'Dibatalkan'};
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
      if (item['id'] == id) {
        return {
          ...item,
          'date': newDate,
          'time': newTime,
          'status': 'Dijadwalkan Ulang',
        };
      }
      return item;
    }).toList();
  }
}
