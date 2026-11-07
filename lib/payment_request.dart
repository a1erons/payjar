import 'package:collection/collection.dart';
import 'payjar.dart';

/// {@template payment_request}
///
/// This holds the information required to initiate a payment request.
///
/// {@endtemplate}
class PaymentRequest {
  // ========================================================
  // === Helper ========================================
  // ========================================================

  static final _deepEquality = DeepCollectionEquality();

  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// The payment amount.
  final int amount;

  /// The unique reference used to identify the payment.
  final String reference;

  /// The currency in which the payment is to be made.
  final Currency currency;

  /// This is the person paying the fee
  final FeePaidBy feePaidBy;

  /// Your own JSON object, returned unchanged.
  final Map<String, Object?> metadata;

  /// This is the customer details
  final CustomerDetails customerDetails;

  /// This creates a payment request.
  const PaymentRequest({
    required this.amount,
    required this.reference,
    required this.currency,
    required this.feePaidBy,
    required this.metadata,
    required this.customerDetails,
  });

  /// This creates a `payment request` from the map provided.
  factory PaymentRequest.fromMap(Map<String, Object?> src) {
    return PaymentRequest(
      amount: src["amount"] as int? ?? 0,
      reference: src["reference"] as String? ?? "",
      currency: Currency.fromValue(src["currency"] as String?),
      feePaidBy: FeePaidBy.fromValue(src["fee_paid_by"] as String?),
      metadata: UnmodifiableMapView(
        Map<String, Object?>.from(src["metadata"] as Map? ?? const {}),
      ),

      customerDetails: CustomerDetails.fromMap(src),
    );
  }

  /// This creates a new copy of `payment request`.
  PaymentRequest copyWith({
    int? amount,
    String? reference,
    Currency? currency,
    FeePaidBy? feePaidBy,
    Map<String, Object?>? metadata,
    CustomerDetails? customerDetails,
  }) {
    return PaymentRequest(
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      currency: currency ?? this.currency,
      feePaidBy: feePaidBy ?? this.feePaidBy,
      metadata: metadata ?? this.metadata,
      customerDetails: customerDetails ?? this.customerDetails,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment request` to a map without customer details
  Map<String, Object?> get toMapWithoutCustomerDetails => UnmodifiableMapView({
    "amount": amount,
    "reference": reference,
    "currency": currency.name.toUpperCase(),
    "fee_paid_by": feePaidBy.name,
    "metadata": metadata.isEmpty ? null : UnmodifiableMapView(metadata),
  });

  /// This converts `payment request` to a map.
  Map<String, Object?> get toMap => UnmodifiableMapView({
    ...toMapWithoutCustomerDetails,
    ...customerDetails.toMap,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentRequest) return false;

    return amount == other.amount &&
        reference == other.reference &&
        currency == other.currency &&
        _deepEquality.equals(metadata, other.metadata) &&
        customerDetails == other.customerDetails;
  }

  @override
  int get hashCode => Object.hash(
    amount,
    reference,
    currency,
    _deepEquality.hash(metadata),
    customerDetails,
  );
}
