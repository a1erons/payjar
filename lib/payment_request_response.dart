import 'dart:collection';
import 'payjar.dart';

/// {@template payment_request_response}
///
/// This is the response of this payment
///
/// {@endtemplate}
class PaymentRequestResponse {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// This will be true if request received a response
  final bool isSuccess;

  /// This is the message attached to this response
  final String message;

  /// This is payjar payment options
  final PayjarRequestOptions? options;

  /// This creates a `payment request response` instance
  const PaymentRequestResponse({
    this.isSuccess = false,
    this.message = "",
    this.options,
  });

  /// This creates an empty `payment request response`.
  const PaymentRequestResponse.empty() : this(isSuccess: false, message: "");

  /// This creates a `payment request response` from map provided
  factory PaymentRequestResponse.fromMap(Map<String, Object?> src) {
    return PaymentRequestResponse(
      isSuccess: src["success"] as bool? ?? false,
      message: src["message"] as String? ?? "",
      options: PayjarRequestOptions.fromMap(
        Map<String, Object?>.from(src["options"] as Map? ?? const {}),
      ),
    );
  }

  /// This creates a new copy of `payment request response`
  PaymentRequestResponse copyWith({
    bool? isSuccess,
    String? message,
    PayjarRequestOptions? options,
  }) {
    return PaymentRequestResponse(
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      options: options ?? this.options,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment request response` to a map
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "success": isSuccess,
    "message": message,
    "options": options?.toMap,
  });

  /// Whether this `payment request response` is empty.
  bool get isEmpty => !isSuccess && message.isEmpty && options == null;

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentRequestResponse) return false;

    return isSuccess == other.isSuccess &&
        message == other.message &&
        options == other.options;
  }

  @override
  int get hashCode => Object.hash(isSuccess, message, options);
}
