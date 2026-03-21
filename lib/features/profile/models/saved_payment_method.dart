class SavedPaymentMethod {
  static const String typeCash = 'cash';
  static const String typeBankTransfer = 'bank_transfer';
  static const String typeEWallet = 'ewallet';

  final String id;
  final String type;
  final String label;
  final String accountName;
  final String accountNumber;
  final bool isDefault;

  const SavedPaymentMethod({
    required this.id,
    required this.type,
    required this.label,
    required this.accountName,
    required this.accountNumber,
    this.isDefault = false,
  });

  factory SavedPaymentMethod.fromMap(Map<String, dynamic> map) {
    return SavedPaymentMethod(
      id: map['id'] as String? ?? '',
      type: normalizeType(map['type'] as String?),
      label: map['label'] as String? ?? '-',
      accountName: map['accountName'] as String? ?? '-',
      accountNumber: map['accountNumber'] as String? ?? '-',
      isDefault: map['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'label': label,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'isDefault': isDefault,
    };
  }

  SavedPaymentMethod copyWith({
    String? id,
    String? type,
    String? label,
    String? accountName,
    String? accountNumber,
    bool? isDefault,
  }) {
    return SavedPaymentMethod(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  String get typeLabel => labelForType(type);

  static String normalizeType(String? rawType) {
    if (rawType == typeCash || rawType == 'Tunai') {
      return typeCash;
    }
    if (rawType == typeBankTransfer || rawType == 'Transfer Bank') {
      return typeBankTransfer;
    }
    return typeEWallet;
  }

  static String labelForType(String type) {
    if (type == typeCash) {
      return 'Tunai';
    }
    if (type == typeBankTransfer) {
      return 'Transfer Bank';
    }
    return 'E-Wallet';
  }
}
