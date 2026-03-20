import 'package:flutter_riverpod/legacy.dart';

final prescriptionsProvider =
    StateNotifierProvider<PrescriptionsNotifier, List<Map<String, dynamic>>>(
      (ref) => PrescriptionsNotifier(),
    );

class PrescriptionsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  PrescriptionsNotifier() : super(_dummyPrescriptions);

  void markAsCompleted(String id) {
    state = state.map((item) {
      if (item['id'] == id) {
        return {...item, 'status': 'Selesai'};
      }
      return item;
    }).toList();
  }
}

final List<Map<String, dynamic>> _dummyPrescriptions = [
  {
    'id': 'rx_1',
    'doctorName': 'Dr. Amanda Putri, Sp.PD',
    'date': '17 Maret 2026',
    'status': 'Aktif',
    'notes':
        'Minum obat setelah makan dan perbanyak istirahat. Jika tekanan darah tetap tinggi, lakukan kontrol ulang.',
    'medicines': [
      {
        'name': 'Amlodipine 5 mg',
        'dosage': '1 tablet',
        'frequency': '1x sehari setelah sarapan',
      },
      {
        'name': 'Paracetamol 500 mg',
        'dosage': '1 tablet',
        'frequency': '3x sehari bila perlu',
      },
    ],
  },
  {
    'id': 'rx_2',
    'doctorName': 'Dr. Budi Santoso, Sp.A',
    'date': '15 Maret 2026',
    'status': 'Menunggu Tebus',
    'notes':
        'Obat diberikan untuk menurunkan demam dan membantu pemulihan. Pastikan anak cukup minum.',
    'medicines': [
      {
        'name': 'Sirup Paracetamol',
        'dosage': '5 ml',
        'frequency': '3x sehari',
      },
      {
        'name': 'Vitamin C Anak',
        'dosage': '1 tablet kunyah',
        'frequency': '1x sehari',
      },
    ],
  },
  {
    'id': 'rx_3',
    'doctorName': 'Dr. Citra Lestari, Sp.KK',
    'date': '10 Maret 2026',
    'status': 'Selesai',
    'notes':
        'Lanjutkan perawatan kulit dan hindari sabun dengan bahan iritatif selama masa pengobatan.',
    'medicines': [
      {
        'name': 'Cetirizine 10 mg',
        'dosage': '1 tablet',
        'frequency': '1x malam hari',
      },
      {
        'name': 'Krim Hydrocortisone',
        'dosage': 'Oles tipis',
        'frequency': '2x sehari',
      },
    ],
  },
];
