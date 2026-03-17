import 'package:flutter_riverpod/legacy.dart';

final pharmacyOrdersProvider =
    StateNotifierProvider<PharmacyOrdersNotifier, List<Map<String, dynamic>>>(
      (ref) => PharmacyOrdersNotifier(),
    );

class PharmacyOrdersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  PharmacyOrdersNotifier() : super(_dummyPharmacyOrders);

  void addOrder(Map<String, dynamic> order) {
    state = [order, ...state];
  }
}

final List<Map<String, dynamic>> _dummyPharmacyOrders = [
  {
    'id': 'ord_2',
    'orderNumber': 'ORD-24031502',
    'orderDate': '15 Maret 2026',
    'status': 'Diproses Farmasi',
    'doctorName': 'Dr. Budi Santoso, Sp.A',
    'prescriptionDate': '15 Maret 2026',
    'deliveryMethod': 'Same Day',
    'shippingAddress': {
      'recipient': 'Alwan Maulana',
      'phone': '0812-3456-7890',
      'address': 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    },
    'medicines': [
      {
        'name': 'Sirup Paracetamol',
        'dosage': '5 ml',
        'frequency': '3x sehari',
        'price': 25000,
      },
      {
        'name': 'Vitamin C Anak',
        'dosage': '1 tablet kunyah',
        'frequency': '1x sehari',
        'price': 18000,
      },
    ],
    'subtotal': 43000,
    'shippingCost': 18000,
    'total': 61000,
  },
  {
    'id': 'ord_1',
    'orderNumber': 'ORD-24031001',
    'orderDate': '10 Maret 2026',
    'status': 'Dikirim',
    'doctorName': 'Dr. Citra Lestari, Sp.KK',
    'prescriptionDate': '10 Maret 2026',
    'deliveryMethod': 'Reguler',
    'shippingAddress': {
      'recipient': 'Alwan Maulana',
      'phone': '0812-3456-7890',
      'address': 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    },
    'medicines': [
      {
        'name': 'Cetirizine 10 mg',
        'dosage': '1 tablet',
        'frequency': '1x malam hari',
        'price': 32000,
      },
      {
        'name': 'Krim Hydrocortisone',
        'dosage': 'Oles tipis',
        'frequency': '2x sehari',
        'price': 22000,
      },
    ],
    'subtotal': 54000,
    'shippingCost': 9000,
    'total': 63000,
  },
];
