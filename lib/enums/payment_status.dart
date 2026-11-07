import 'dart:collection';
import 'extensions/payment_status_ext.dart';

export 'extensions/payment_status_ext.dart';

/// {@template payment_status}
///
/// Specifies the current state and lifecycle stage of a payment or bank transfer transaction.
///
/// Tracks the payment from creation ([awaitingTransfer] / [pending]) through successful
/// completion ([success]), or terminal states such as expiration ([expired]), failure ([failed]),
/// or cancellation ([cancelled]).
///
/// {@endtemplate}
enum PaymentStatus {
  /// Fallback value for unrecognized, missing, or uninitialized payment statuses.
  unknown,

  /// Gateway is waiting for the bank transfer. Normal status right after payment creation.
  awaitingTransfer,

  /// The payment exists and is not paid yet.
  pending,

  /// The transfer has arrived successfully. The order can be fulfilled/delivered.
  success,

  /// The payment window ran out before the transfer arrived.
  expired,

  /// The payment attempt failed.
  failed,

  /// The payment was cancelled.
  cancelled;

  /// Creates a [PaymentStatus] enum from the provided [value].
  ///
  /// Normalizes string comparison to support both camelCase and snake_case
  /// (e.g., `"awaiting_transfer"` or `"awaitingTransfer"`).
  /// Falls back to [PaymentStatus.unknown] if the input is unrecognized or null.
  factory PaymentStatus.fromValue(Object? value) {
    final normalized = (value as String? ?? "").trim().toLowerCase().replaceAll(
      '_',
      '',
    );
    return values.firstWhere(
      (e) => e.name.toLowerCase() == normalized,
      orElse: () => unknown,
    );
  }

  /// Returns a list of all known payment statuses (excluding [unknown]).
  static List<PaymentStatus> get knownStatuses => UnmodifiableListView(
    PaymentStatus.values.where((e) => !e.isUnknown).toList(),
  );
}
