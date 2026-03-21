import 'pharmacy_order_item.dart';
import 'shipping_address.dart';

class PharmacyOrder {
  static const String paymentStatusUnpaid = 'unpaid';
  static const String paymentStatusPending = 'pending';
  static const String paymentStatusPaid = 'paid';
  static const String paymentStatusFailed = 'failed';

  static const String fulfillmentStatusWaitingPayment = 'waiting_payment';
  static const String fulfillmentStatusProcessing = 'processing';
  static const String fulfillmentStatusShipped = 'shipped';
  static const String fulfillmentStatusCompleted = 'completed';

  final String id;
  final String prescriptionId;
  final String orderNumber;
  final String orderDate;
  final String paymentStatus;
  final String fulfillmentStatus;
  final String doctorName;
  final String prescriptionDate;
  final String deliveryMethod;
  final ShippingAddress shippingAddress;
  final List<PharmacyOrderItem> medicines;
  final int subtotal;
  final int shippingCost;
  final int total;

  const PharmacyOrder({
    required this.id,
    required this.prescriptionId,
    required this.orderNumber,
    required this.orderDate,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.doctorName,
    required this.prescriptionDate,
    required this.deliveryMethod,
    required this.shippingAddress,
    required this.medicines,
    required this.subtotal,
    required this.shippingCost,
    required this.total,
  });

  factory PharmacyOrder.fromMap(Map<String, dynamic> map) {
    final medicines =
        (map['medicines'] as List<dynamic>? ?? [])
            .whereType<Map>()
            .map(
              (item) =>
                  PharmacyOrderItem.fromMap(Map<String, dynamic>.from(item)),
            )
            .toList();

    return PharmacyOrder(
      id: map['id'] as String? ?? '',
      prescriptionId: map['prescriptionId'] as String? ?? '',
      orderNumber: map['orderNumber'] as String? ?? '-',
      orderDate: map['orderDate'] as String? ?? '-',
      paymentStatus: normalizePaymentStatus(map['paymentStatus'] as String?),
      fulfillmentStatus: normalizeFulfillmentStatus(
        map['fulfillmentStatus'] as String?,
      ),
      doctorName: map['doctorName'] as String? ?? '-',
      prescriptionDate: map['prescriptionDate'] as String? ?? '-',
      deliveryMethod: map['deliveryMethod'] as String? ?? '-',
      shippingAddress: ShippingAddress.fromMap(
        map['shippingAddress'] as Map<String, dynamic>? ?? const {},
      ),
      medicines: medicines,
      subtotal: map['subtotal'] as int? ?? 0,
      shippingCost: map['shippingCost'] as int? ?? 0,
      total: map['total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prescriptionId': prescriptionId,
      'orderNumber': orderNumber,
      'orderDate': orderDate,
      'paymentStatus': paymentStatus,
      'fulfillmentStatus': fulfillmentStatus,
      'doctorName': doctorName,
      'prescriptionDate': prescriptionDate,
      'deliveryMethod': deliveryMethod,
      'shippingAddress': shippingAddress.toMap(),
      'medicines': medicines.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'shippingCost': shippingCost,
      'total': total,
    };
  }

  PharmacyOrder copyWith({
    String? id,
    String? prescriptionId,
    String? orderNumber,
    String? orderDate,
    String? paymentStatus,
    String? fulfillmentStatus,
    String? doctorName,
    String? prescriptionDate,
    String? deliveryMethod,
    ShippingAddress? shippingAddress,
    List<PharmacyOrderItem>? medicines,
    int? subtotal,
    int? shippingCost,
    int? total,
  }) {
    return PharmacyOrder(
      id: id ?? this.id,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      fulfillmentStatus: fulfillmentStatus ?? this.fulfillmentStatus,
      doctorName: doctorName ?? this.doctorName,
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      medicines: medicines ?? this.medicines,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      total: total ?? this.total,
    );
  }

  String get paymentStatusLabel => labelForPaymentStatus(paymentStatus);

  String get fulfillmentStatusLabel =>
      labelForFulfillmentStatus(fulfillmentStatus);

  static String normalizePaymentStatus(String? rawStatus) {
    if (rawStatus == paymentStatusPaid || rawStatus == 'Lunas') {
      return paymentStatusPaid;
    }
    if (rawStatus == paymentStatusPending || rawStatus == 'Menunggu') {
      return paymentStatusPending;
    }
    if (rawStatus == paymentStatusFailed || rawStatus == 'Gagal') {
      return paymentStatusFailed;
    }
    return paymentStatusUnpaid;
  }

  static String normalizeFulfillmentStatus(String? rawStatus) {
    if (rawStatus == fulfillmentStatusCompleted || rawStatus == 'Selesai') {
      return fulfillmentStatusCompleted;
    }
    if (rawStatus == fulfillmentStatusShipped || rawStatus == 'Dikirim') {
      return fulfillmentStatusShipped;
    }
    if (rawStatus == fulfillmentStatusProcessing ||
        rawStatus == 'Diproses Farmasi') {
      return fulfillmentStatusProcessing;
    }
    return fulfillmentStatusWaitingPayment;
  }

  static String labelForPaymentStatus(String status) {
    if (status == paymentStatusPaid) {
      return 'Lunas';
    }
    if (status == paymentStatusPending) {
      return 'Menunggu';
    }
    if (status == paymentStatusFailed) {
      return 'Gagal';
    }
    return 'Belum Dibayar';
  }

  static String labelForFulfillmentStatus(String status) {
    if (status == fulfillmentStatusCompleted) {
      return 'Selesai';
    }
    if (status == fulfillmentStatusShipped) {
      return 'Dikirim';
    }
    if (status == fulfillmentStatusProcessing) {
      return 'Diproses Farmasi';
    }
    return 'Menunggu Pembayaran';
  }
}
