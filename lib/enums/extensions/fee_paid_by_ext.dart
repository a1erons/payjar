import 'package:payjar/enums/fee_paid_by.dart';

/// Extension on [FeePaidBy] providing convenient boolean getters for fee payer checks.
extension FeePaidByExt on FeePaidBy {
  /// This will be true if fee payer is unknown
  bool get isUnknown => this == FeePaidBy.unknown;

  /// This will be true if the customer is responsible for the fee
  bool get isCustomer => this == FeePaidBy.customer;

  /// This will be true if the merchant is responsible for the fee
  bool get isMerchant => this == FeePaidBy.merchant;
}
