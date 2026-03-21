import 'package:flutter_riverpod/legacy.dart';

import '../models/pharmacy_order.dart';
import '../models/pharmacy_order_item.dart';
import '../models/shipping_address.dart';

final pharmacyOrdersProvider =
    StateNotifierProvider<PharmacyOrdersNotifier, List<PharmacyOrder>>(
      (ref) => PharmacyOrdersNotifier(),
    );

class PharmacyOrdersNotifier extends StateNotifier<List<PharmacyOrder>> {
  PharmacyOrdersNotifier() : super(_dummyPharmacyOrders);

  void addOrder(PharmacyOrder order) {
    state = [order, ...state];
  }

  void markOrderAsPaid(String id) {
    state = state.map((order) {
      if (order.id != id) {
        return order;
      }

      return order.copyWith(
        paymentStatus: PharmacyOrder.paymentStatusPaid,
        fulfillmentStatus: PharmacyOrder.fulfillmentStatusProcessing,
      );
    }).toList();
  }

  void updateFulfillmentStatus({
    required String id,
    required String fulfillmentStatus,
  }) {
    state = state.map((order) {
      if (order.id != id) {
        return order;
      }

      return order.copyWith(
        fulfillmentStatus: PharmacyOrder.normalizeFulfillmentStatus(
          fulfillmentStatus,
        ),
      );
    }).toList();
  }
}

final List<PharmacyOrder> _dummyPharmacyOrders = [
  PharmacyOrder(
    id: 'ord_2',
    prescriptionId: 'rx_2',
    orderNumber: 'ORD-24031502',
    orderDate: '15 Maret 2026',
    paymentStatus: PharmacyOrder.paymentStatusPaid,
    fulfillmentStatus: PharmacyOrder.fulfillmentStatusProcessing,
    doctorName: 'Dr. Budi Santoso, Sp.A',
    prescriptionDate: '15 Maret 2026',
    deliveryMethod: 'Same Day',
    shippingAddress: const ShippingAddress(
      recipient: 'Alwan Maulana',
      phone: '0812-3456-7890',
      address: 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    ),
    medicines: const [
      PharmacyOrderItem(
        name: 'Sirup Paracetamol',
        dosage: '5 ml',
        frequency: '3x sehari',
        price: 25000,
      ),
      PharmacyOrderItem(
        name: 'Vitamin C Anak',
        dosage: '1 tablet kunyah',
        frequency: '1x sehari',
        price: 18000,
      ),
    ],
    subtotal: 43000,
    shippingCost: 18000,
    total: 61000,
  ),
  PharmacyOrder(
    id: 'ord_1',
    prescriptionId: 'rx_1',
    orderNumber: 'ORD-24031001',
    orderDate: '10 Maret 2026',
    paymentStatus: PharmacyOrder.paymentStatusPaid,
    fulfillmentStatus: PharmacyOrder.fulfillmentStatusShipped,
    doctorName: 'Dr. Citra Lestari, Sp.KK',
    prescriptionDate: '10 Maret 2026',
    deliveryMethod: 'Reguler',
    shippingAddress: const ShippingAddress(
      recipient: 'Alwan Maulana',
      phone: '0812-3456-7890',
      address: 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    ),
    medicines: const [
      PharmacyOrderItem(
        name: 'Cetirizine 10 mg',
        dosage: '1 tablet',
        frequency: '1x malam hari',
        price: 32000,
      ),
      PharmacyOrderItem(
        name: 'Krim Hydrocortisone',
        dosage: 'Oles tipis',
        frequency: '2x sehari',
        price: 22000,
      ),
    ],
    subtotal: 54000,
    shippingCost: 9000,
    total: 63000,
  ),
];
