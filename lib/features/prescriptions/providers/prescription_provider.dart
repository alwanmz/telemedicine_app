import 'package:flutter_riverpod/legacy.dart';

import '../models/prescription.dart';
import '../models/prescription_medicine.dart';

final prescriptionsProvider =
    StateNotifierProvider<PrescriptionsNotifier, List<Prescription>>(
      (ref) => PrescriptionsNotifier(),
    );

class PrescriptionsNotifier extends StateNotifier<List<Prescription>> {
  PrescriptionsNotifier() : super(_dummyPrescriptions);

  void markAsCompleted(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(status: Prescription.statusCompleted);
      }
      return item;
    }).toList();
  }
}

final List<Prescription> _dummyPrescriptions = [
  const Prescription(
    id: 'rx_1',
    doctorName: 'Dr. Amanda Putri, Sp.PD',
    date: '17 Maret 2026',
    status: Prescription.statusActive,
    notes:
        'Minum obat setelah makan dan perbanyak istirahat. Jika tekanan darah tetap tinggi, lakukan kontrol ulang.',
    medicines: [
      PrescriptionMedicine(
        name: 'Amlodipine 5 mg',
        dosage: '1 tablet',
        frequency: '1x sehari setelah sarapan',
      ),
      PrescriptionMedicine(
        name: 'Paracetamol 500 mg',
        dosage: '1 tablet',
        frequency: '3x sehari bila perlu',
      ),
    ],
  ),
  const Prescription(
    id: 'rx_2',
    doctorName: 'Dr. Budi Santoso, Sp.A',
    date: '15 Maret 2026',
    status: Prescription.statusPendingRedeem,
    notes:
        'Obat diberikan untuk menurunkan demam dan membantu pemulihan. Pastikan anak cukup minum.',
    medicines: [
      PrescriptionMedicine(
        name: 'Sirup Paracetamol',
        dosage: '5 ml',
        frequency: '3x sehari',
      ),
      PrescriptionMedicine(
        name: 'Vitamin C Anak',
        dosage: '1 tablet kunyah',
        frequency: '1x sehari',
      ),
    ],
  ),
  const Prescription(
    id: 'rx_3',
    doctorName: 'Dr. Citra Lestari, Sp.KK',
    date: '10 Maret 2026',
    status: Prescription.statusCompleted,
    notes:
        'Lanjutkan perawatan kulit dan hindari sabun dengan bahan iritatif selama masa pengobatan.',
    medicines: [
      PrescriptionMedicine(
        name: 'Cetirizine 10 mg',
        dosage: '1 tablet',
        frequency: '1x malam hari',
      ),
      PrescriptionMedicine(
        name: 'Krim Hydrocortisone',
        dosage: 'Oles tipis',
        frequency: '2x sehari',
      ),
    ],
  ),
];
