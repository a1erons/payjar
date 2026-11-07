import '../currency.dart';

/// Extension on [Currency] providing convenient boolean getters for currency checks.
extension CurrencyExt on Currency {
  /// This will be true if currency is unknown
  bool get isUnknown => this == Currency.unknown;

  /// This will be true if currency is USD
  bool get isUsd => this == Currency.usd;

  /// This will be true if currency is EUR
  bool get isEur => this == Currency.eur;

  /// This will be true if currency is GBP
  bool get isGbp => this == Currency.gbp;

  /// This will be true if currency is NGN
  bool get isNgn => this == Currency.ngn;

  /// This will be true if currency is CAD
  bool get isCad => this == Currency.cad;

  /// This will be true if currency is AUD
  bool get isAud => this == Currency.aud;

  /// This will be true if currency is JPY
  bool get isJpy => this == Currency.jpy;
}
