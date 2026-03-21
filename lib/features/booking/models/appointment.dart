class Appointment {
  static const String statusScheduled = 'scheduled';
  static const String statusRescheduled = 'rescheduled';
  static const String statusCancelled = 'cancelled';

  static const String paymentStatusUnpaid = 'unpaid';
  static const String paymentStatusPending = 'pending';
  static const String paymentStatusPaid = 'paid';

  final String id;
  final String doctorName;
  final String specialization;
  final String hospital;
  final String date;
  final String time;
  final String consultationType;
  final String patientType;
  final String complaint;
  final String allergyHistory;
  final String bloodPressure;
  final String bodyTemperature;
  final String weight;
  final String height;
  final String paymentMethod;
  final String paymentStatus;
  final String invoiceNumber;
  final String totalPrice;
  final String status;

  const Appointment({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.hospital,
    required this.date,
    required this.time,
    required this.consultationType,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.invoiceNumber,
    required this.totalPrice,
    required this.status,
    this.patientType = '',
    this.complaint = '',
    this.allergyHistory = '',
    this.bloodPressure = '',
    this.bodyTemperature = '',
    this.weight = '',
    this.height = '',
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    final paymentMethod = map['paymentMethod'] as String? ?? '-';

    return Appointment(
      id: map['id'] as String? ?? '',
      doctorName: map['doctorName'] as String? ?? '-',
      specialization: map['specialization'] as String? ?? '-',
      hospital: map['hospital'] as String? ?? '-',
      date: map['date'] as String? ?? '-',
      time: map['time'] as String? ?? '-',
      consultationType: map['consultationType'] as String? ?? '-',
      patientType: map['patientType'] as String? ?? '',
      complaint: map['complaint'] as String? ?? '',
      allergyHistory: map['allergyHistory'] as String? ?? '',
      bloodPressure: map['bloodPressure'] as String? ?? '',
      bodyTemperature: map['bodyTemperature'] as String? ?? '',
      weight: map['weight'] as String? ?? '',
      height: map['height'] as String? ?? '',
      paymentMethod: paymentMethod,
      paymentStatus: normalizePaymentStatus(
        map['paymentStatus'] as String?,
        paymentMethod: paymentMethod,
      ),
      invoiceNumber: map['invoiceNumber'] as String? ?? '-',
      totalPrice: map['totalPrice'] as String? ?? 'Rp 80.000',
      status: normalizeStatus(map['status'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorName': doctorName,
      'specialization': specialization,
      'hospital': hospital,
      'date': date,
      'time': time,
      'consultationType': consultationType,
      'patientType': patientType,
      'complaint': complaint,
      'allergyHistory': allergyHistory,
      'bloodPressure': bloodPressure,
      'bodyTemperature': bodyTemperature,
      'weight': weight,
      'height': height,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'invoiceNumber': invoiceNumber,
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  Appointment copyWith({
    String? id,
    String? doctorName,
    String? specialization,
    String? hospital,
    String? date,
    String? time,
    String? consultationType,
    String? patientType,
    String? complaint,
    String? allergyHistory,
    String? bloodPressure,
    String? bodyTemperature,
    String? weight,
    String? height,
    String? paymentMethod,
    String? paymentStatus,
    String? invoiceNumber,
    String? totalPrice,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      specialization: specialization ?? this.specialization,
      hospital: hospital ?? this.hospital,
      date: date ?? this.date,
      time: time ?? this.time,
      consultationType: consultationType ?? this.consultationType,
      patientType: patientType ?? this.patientType,
      complaint: complaint ?? this.complaint,
      allergyHistory: allergyHistory ?? this.allergyHistory,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bodyTemperature: bodyTemperature ?? this.bodyTemperature,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
    );
  }

  String get statusLabel => labelForStatus(status);

  String get paymentStatusLabel => labelForPaymentStatus(paymentStatus);

  static String normalizeStatus(String? rawStatus) {
    if (rawStatus == statusCancelled || rawStatus == 'Dibatalkan') {
      return statusCancelled;
    }
    if (rawStatus == statusRescheduled || rawStatus == 'Dijadwalkan Ulang') {
      return statusRescheduled;
    }
    return statusScheduled;
  }

  static String normalizePaymentStatus(
    String? rawStatus, {
    String? paymentMethod,
  }) {
    if (rawStatus == paymentStatusPaid) {
      return paymentStatusPaid;
    }
    if (rawStatus == paymentStatusPending) {
      return paymentStatusPending;
    }
    if (rawStatus == paymentStatusUnpaid) {
      return paymentStatusUnpaid;
    }

    return resolveInitialPaymentStatus(paymentMethod ?? '');
  }

  static String resolveInitialPaymentStatus(String paymentMethod) {
    if (paymentMethod == 'Tunai') {
      return paymentStatusUnpaid;
    }

    return paymentStatusPending;
  }

  static String labelForStatus(String status) {
    if (status == statusCancelled) {
      return 'Dibatalkan';
    }
    if (status == statusRescheduled) {
      return 'Dijadwalkan Ulang';
    }
    return 'Terjadwal';
  }

  static String labelForPaymentStatus(String status) {
    if (status == paymentStatusPaid) {
      return 'Lunas';
    }
    if (status == paymentStatusPending) {
      return 'Menunggu';
    }
    if (status == paymentStatusUnpaid) {
      return 'Belum Dibayar';
    }
    return '-';
  }
}
