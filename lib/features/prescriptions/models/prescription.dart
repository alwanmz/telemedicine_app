import 'prescription_medicine.dart';

class Prescription {
  static const String statusActive = 'active';
  static const String statusPendingRedeem = 'pending_redeem';
  static const String statusCompleted = 'completed';

  final String id;
  final String doctorName;
  final String date;
  final String status;
  final String notes;
  final List<PrescriptionMedicine> medicines;

  const Prescription({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.status,
    required this.notes,
    required this.medicines,
  });

  factory Prescription.fromMap(Map<String, dynamic> map) {
    final medicines =
        (map['medicines'] as List<dynamic>? ?? [])
            .whereType<Map>()
            .map((item) => PrescriptionMedicine.fromMap(Map<String, dynamic>.from(item)))
            .toList();

    return Prescription(
      id: map['id'] as String? ?? '',
      doctorName: map['doctorName'] as String? ?? '-',
      date: map['date'] as String? ?? '-',
      status: normalizeStatus(map['status'] as String?),
      notes: map['notes'] as String? ?? '-',
      medicines: medicines,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorName': doctorName,
      'date': date,
      'status': status,
      'notes': notes,
      'medicines': medicines.map((item) => item.toMap()).toList(),
    };
  }

  Prescription copyWith({
    String? id,
    String? doctorName,
    String? date,
    String? status,
    String? notes,
    List<PrescriptionMedicine>? medicines,
  }) {
    return Prescription(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      date: date ?? this.date,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      medicines: medicines ?? this.medicines,
    );
  }

  String get statusLabel => labelForStatus(status);

  bool get isRedeemable => status == statusActive;

  static String normalizeStatus(String? rawStatus) {
    if (rawStatus == statusCompleted || rawStatus == 'Selesai') {
      return statusCompleted;
    }
    if (rawStatus == statusPendingRedeem || rawStatus == 'Menunggu Tebus') {
      return statusPendingRedeem;
    }
    return statusActive;
  }

  static String labelForStatus(String status) {
    if (status == statusCompleted) {
      return 'Selesai';
    }
    if (status == statusPendingRedeem) {
      return 'Menunggu Tebus';
    }
    return 'Aktif';
  }
}
