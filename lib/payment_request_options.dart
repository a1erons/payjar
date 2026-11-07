import 'dart:collection';
import 'payjar.dart';

/// {@template payjar_request_options}
///
/// This is payjar's request options
///
/// {@endtemplate}
class PayjarRequestOptions {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// This holds the actual payment data
  final PayjarPayment payment;

  /// This is pay jars response notification count
  final int notificationCount;

  /// This creates a `payment request options`
  const PayjarRequestOptions({
    required this.payment,
    required this.notificationCount,
  });

  /// This creates `payment request options` from map provided
  factory PayjarRequestOptions.fromMap(Map<String, Object?> src) {
    return PayjarRequestOptions(
      payment: PayjarPayment.fromMap(
        Map<String, Object?>.from(src["payment"] as Map? ?? const {}),
      ),
      notificationCount: src["notifications_count"] as int? ?? 0,
    );
  }

  /// This creates a new copy of `payment request options`
  PayjarRequestOptions copyWith({
    PayjarPayment? payment,
    int? notificationCount,
  }) {
    return PayjarRequestOptions(
      payment: payment ?? this.payment,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment request options` to a map
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "payment": payment.toMap,
    "notifications_count": notificationCount,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayjarRequestOptions) return false;

    return payment == other.payment &&
        notificationCount == other.notificationCount;
  }

  @override
  int get hashCode => Object.hash(payment, notificationCount);
}
