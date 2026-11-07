import 'dart:collection';

/// {@template payment_breakdown}
///
/// This holds the financial breakdown of a payment, including the original
/// amount, applicable fee, charged amount and final settled amount.
///
/// {@endtemplate}
class PaymentBreakdown {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// The fee associated with processing the payment.
  final int fee;

  /// The total amount charged for the payment.
  final int chargedAmount;

  /// The final amount settled after applicable fees are deducted.
  final int settledAmount;

  /// This creates a payment breakdown.
  const PaymentBreakdown({
    required this.fee,
    required this.chargedAmount,
    required this.settledAmount,
  });

  /// This creates a `payment breakdown` from the map provided.
  factory PaymentBreakdown.fromMap(Map<String, Object?> src) {
    return PaymentBreakdown(
      fee: src["fee"] as int? ?? 0,
      chargedAmount: src["charged_amount"] as int? ?? 0,
      settledAmount: src["settled_amount"] as int? ?? 0,
    );
  }

  /// This creates a new copy of `payment breakdown`.
  PaymentBreakdown copyWith({
    int? fee,
    int? chargedAmount,
    int? settledAmount,
  }) {
    return PaymentBreakdown(
      fee: fee ?? this.fee,
      chargedAmount: chargedAmount ?? this.chargedAmount,
      settledAmount: settledAmount ?? this.settledAmount,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment breakdown` to a map.
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "fee": fee,
    "charged_amount": chargedAmount,
    "settled_amount": settledAmount,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentBreakdown) return false;

    return fee == other.fee &&
        chargedAmount == other.chargedAmount &&
        settledAmount == other.settledAmount;
  }

  @override
  int get hashCode => Object.hash(fee, chargedAmount, settledAmount);
}
