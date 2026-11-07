import 'extensions/fee_paid_by_ext.dart';

/// {@template fee_payer}
///
/// Specifies the entity responsible for covering transaction, processing, or platform fees.
///
/// Determines whether the transaction fee is charged to the end-user ([customer])
/// or absorbed by the business/platform provider ([merchant]).
///
/// {@endtemplate}
enum FeePaidBy {
  /// Fallback value for unrecognized, missing, or uninitialized fee payer configuration.
  unknown,

  /// The customer pays the processing or transaction fee.
  customer,

  /// The merchant or business absorbs the transaction fee.
  merchant;

  /// Creates a [FeePaidBy] enum from the provided [value].
  ///
  /// Falls back to [FeePaidBy.unknown] if the input is unrecognized or null.
  factory FeePaidBy.fromValue(Object? value) {
    return values.firstWhere(
      (e) =>
          e.name.toLowerCase() == (value as String? ?? "").trim().toLowerCase(),
      orElse: () => unknown,
    );
  }

  /// Returns a list of all known fee payers (excluding [unknown]).
  static List<FeePaidBy> get knownPayers =>
      List.unmodifiable(FeePaidBy.values.where((e) => !e.isUnknown).toList());
}
