import 'dart:collection';

/// {@template payment_timestamps}
///
/// This holds the important timestamps associated with a payment, including
/// when it was created, when it expires and when it was successfully paid.
///
/// {@endtemplate}
class PaymentTimestamps {
  // ========================================================
  // === Initializers ========================================
  // ========================================================

  /// The date and time the payment was successfully completed.
  ///
  /// This is null when the payment has not yet been completed.
  final DateTime? paidAt;

  /// The date and time the payment is expected to expire.
  final DateTime? expiresAt;

  /// The date and time the payment was created.
  final DateTime? createdAt;

  /// This creates payment timestamps.
  const PaymentTimestamps({
    required this.paidAt,
    required this.expiresAt,
    required this.createdAt,
  });

  /// This creates `payment timestamps` from the map provided.
  factory PaymentTimestamps.fromMap(Map<String, Object?> src) {
    return PaymentTimestamps(
      paidAt: DateTime.tryParse(src["paid_at"] as String? ?? ""),
      expiresAt: DateTime.tryParse(src["expires_at"] as String? ?? ""),
      createdAt: DateTime.tryParse(src["created_at"] as String? ?? ""),
    );
  }

  /// This creates a new copy of `payment timestamps`.
  PaymentTimestamps copyWith({
    DateTime? paidAt,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return PaymentTimestamps(
      paidAt: paidAt ?? this.paidAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment timestamps` to a map.
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "paid_at": paidAt?.toIso8601String(),
    "expires_at": expiresAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  /// {@macro equality_rule}
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentTimestamps) return false;

    return paidAt == other.paidAt &&
        expiresAt == other.expiresAt &&
        createdAt == other.createdAt;
  }

  /// {@macro hashcode_rule}
  @override
  int get hashCode => Object.hash(paidAt, expiresAt, createdAt);
}
