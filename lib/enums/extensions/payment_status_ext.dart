import '../payment_status.dart';

/// Extension on [PaymentStatus] providing convenient boolean getters for payment state checks.
extension PaymentStatusExt on PaymentStatus {
  /// This will be true if payment status is unknown
  bool get isUnknown => this == PaymentStatus.unknown;

  /// This will be true if waiting for the bank transfer
  bool get isAwaitingTransfer => this == PaymentStatus.awaitingTransfer;

  /// This will be true if payment is pending
  bool get isPending => this == PaymentStatus.pending;

  /// This will be true if the transfer arrived successfully and order can be delivered
  bool get isSuccess => this == PaymentStatus.success;

  /// This will be true if the payment window ran out
  bool get isExpired => this == PaymentStatus.expired;

  /// This will be true if the payment failed
  bool get isFailed => this == PaymentStatus.failed;

  /// This will be true if the payment was cancelled
  bool get isCancelled => this == PaymentStatus.cancelled;

  /// Converts the enum name from camelCase to snake_case for backend payloads.
  ///
  /// Example: [PaymentStatus.awaitingTransfer] becomes `"awaiting_transfer"`.
  String get wireName {
    if (isUnknown) return '';
    return name.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }
}
