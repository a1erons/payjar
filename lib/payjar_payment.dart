import 'dart:collection';
import 'payjar.dart';

/// {@template payjar_payment_options}
///
/// This creates a payjar payment
///
/// {@endtemplate}
class PayjarPayment {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// This is the id of this request
  final int id;

  /// This is the access code of this request
  final String accessCode;

  /// This is the environment of this payment request `live` or `test`
  final Environment environment;

  /// This is the status of this request
  final PaymentStatus paymentStatus;

  /// This is the payment request
  final PaymentRequest paymentRequest;

  /// This is the payment break down
  final PaymentBreakdown paymentBreakdown;

  /// This holds the payment timestamps
  final PaymentTimestamps paymentTimestamps;

  /// This holds the payment urls
  final PaymentUrls paymentUrls;

  /// This is the receiving bank account information
  final BankTransferTo bankTransferTo;

  /// This creates a `payment request response` instance
  const PayjarPayment({
    required this.id,
    required this.accessCode,
    required this.environment,
    required this.paymentStatus,
    required this.paymentRequest,
    required this.paymentBreakdown,
    required this.paymentTimestamps,
    required this.paymentUrls,
    required this.bankTransferTo,
  });

  /// This creates a `payment request response` from map provided
  factory PayjarPayment.fromMap(Map<String, Object?> src) {
    final bank = Map<String, Object?>.from(src["bank"] as Map? ?? const {});

    return PayjarPayment(
      id: src["id"] as int? ?? 0,
      accessCode: src["access_code"] as String? ?? "",
      environment: Environment.fromValue(src["environment"]),
      paymentStatus: PaymentStatus.fromValue(src["status"]),
      paymentRequest: PaymentRequest.fromMap(src).copyWith(
        customerDetails: CustomerDetails(
          id: src["customer_id"] as int? ?? 0,
          email: src["customer_email"] as String? ?? "",
          name: src["customer_name"] as String? ?? "",
          phone: src["customer_phone"] as String? ?? "",
        ),
      ),
      paymentBreakdown: PaymentBreakdown.fromMap(src),
      paymentTimestamps: PaymentTimestamps.fromMap(src),
      paymentUrls: PaymentUrls.fromMap(src),
      bankTransferTo: BankTransferTo(
        accountName: bank["account_name"] as String? ?? "",
        accountNumber: bank["account_number"] as String? ?? "",
        bankName: bank["bank_name"] as String? ?? "",
        bankLogoUrl: bank["bank_logo_url"] as String? ?? "",
      ),
    );
  }

  /// This creates a new copy of `payment request response`
  PayjarPayment copyWith({
    int? id,
    String? accessCode,
    Environment? environment,
    PaymentStatus? paymentStatus,
    PaymentRequest? paymentRequest,
    PaymentBreakdown? paymentBreakdown,
    PaymentTimestamps? paymentTimestamps,
    PaymentUrls? paymentUrls,
    BankTransferTo? bankTransferTo,
    int? notificationCount,
  }) {
    return PayjarPayment(
      id: id ?? this.id,
      accessCode: accessCode ?? this.accessCode,
      environment: environment ?? this.environment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentRequest: paymentRequest ?? this.paymentRequest,
      paymentBreakdown: paymentBreakdown ?? this.paymentBreakdown,
      paymentTimestamps: paymentTimestamps ?? this.paymentTimestamps,
      paymentUrls: paymentUrls ?? this.paymentUrls,
      bankTransferTo: bankTransferTo ?? this.bankTransferTo,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment request response` to a map
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "id": id,
    "access_code": accessCode,
    "environment": environment.name,
    "status": paymentStatus.wireName,
    ...paymentRequest.toMapWithoutCustomerDetails,
    ...paymentBreakdown.toMap,
    ...paymentTimestamps.toMap,
    ...paymentUrls.toMap,
    "bank": {
      ...bankTransferTo.toMap,
      "amount": paymentBreakdown.chargedAmount,
      "currency": paymentRequest.currency.name.toUpperCase(),
    },

    // customer details
    for (final customerDetail in paymentRequest.customerDetails.toMap.entries)
      "customer_${customerDetail.key}": customerDetail.value,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayjarPayment) return false;

    return id == other.id &&
        accessCode == other.accessCode &&
        environment == other.environment &&
        paymentStatus == other.paymentStatus &&
        paymentRequest == other.paymentRequest &&
        paymentBreakdown == other.paymentBreakdown &&
        paymentTimestamps == other.paymentTimestamps &&
        paymentUrls == other.paymentUrls &&
        bankTransferTo == other.bankTransferTo;
  }

  @override
  int get hashCode => Object.hash(
    id,
    accessCode,
    environment,
    paymentStatus,
    paymentRequest,
    paymentBreakdown,
    paymentTimestamps,
    paymentUrls,
    bankTransferTo,
  );
}
