import 'dart:collection';

/// {@template bank_transfer_to}
///
/// Represents a bank account that users can transfer payments to.
///
/// Stores the recipient's account details and the bank's logo information
/// for display within the bank transfer payment flow.
///
/// {@endtemplate}
///
/// {@macro object_blueprint}
class BankTransferTo {
  // ========================================================
  // === Initializers ========================================
  // ========================================================

  /// The account name of the recipient
  final String accountName;

  /// The account number of the recipient
  final String accountNumber;

  /// The bank name of the recipient
  final String bankName;

  /// This is the banks icon/logo
  final String bankLogoUrl;

  /// This creates a bank transfer information
  const BankTransferTo({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankLogoUrl,
  });

  /// This creates an empty `bank transfer to` details
  const BankTransferTo.none()
    : this(accountName: "", accountNumber: "", bankLogoUrl: "", bankName: "");

  /// This creates a `bank transfer to` from map provided
  factory BankTransferTo.fromMap(Map<String, Object?> src) {
    return BankTransferTo(
      accountName: src["account_name"] as String? ?? "",
      accountNumber: src["account_number"] as String? ?? "",
      bankName: src["bank_name"] as String? ?? "",
      bankLogoUrl: src["bank_logo_url"] as String? ?? "",
    );
  }

  /// This creates a new copy of `bank transfer to`
  BankTransferTo copyWith({
    String? accountName,
    String? accountNumber,
    String? bankName,
    String? bankLogoUrl,
  }) {
    return BankTransferTo(
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      bankLogoUrl: bankLogoUrl ?? this.bankLogoUrl,
    );
  }

  // ========================================================
  // === Getters ========================================
  // ========================================================

  /// This converts `bank transfer to` to a map
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "account_name": accountName,
    "account_number": accountNumber,
    "bank_name": bankName.isEmpty ? null : bankName,
    if (bankLogoUrl.isNotEmpty) "bank_logo_url": bankLogoUrl,
  });

  /// Whether a bank account is available for transfer.
  bool get isAvailable => accountNumber.isNotEmpty;

  // ========================================================
  // === Equality ========================================
  // ========================================================

  /// {@macro equality_rule}
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BankTransferTo) return false;

    return accountName == other.accountName &&
        accountNumber == other.accountNumber &&
        bankName == other.bankName &&
        bankLogoUrl == other.bankLogoUrl;
  }

  /// {@macro hashcode_rule}
  @override
  int get hashCode =>
      Object.hash(accountName, accountNumber, bankName, bankLogoUrl);
}
