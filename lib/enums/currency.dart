import 'dart:collection';
import 'extensions/currency_ext.dart';

/// {@template currency}
///
/// Represents supported international and local fiat currencies.
///
/// Used across financial transactions, monetization systems, pricing models,
/// and wallet balances.
///
/// {@endtemplate}
enum Currency {
  /// Fallback value for unrecognized, missing, or uninitialized currencies.
  unknown,

  /// United States Dollar (USD).
  usd,

  /// Euro (EUR).
  eur,

  /// British Pound Sterling (GBP).
  gbp,

  /// Nigerian Naira (NGN).
  ngn,

  /// Canadian Dollar (CAD).
  cad,

  /// Australian Dollar (AUD).
  aud,

  /// Japanese Yen (JPY).
  jpy;

  /// Creates a [Currency] enum from the provided [value].
  ///
  /// Falls back to [Currency.unknown] if the input is unrecognized or null.
  factory Currency.fromValue(Object? value) {
    return values.firstWhere(
      (e) =>
          e.name.toLowerCase() == (value as String? ?? "").trim().toLowerCase(),
      orElse: () => unknown,
    );
  }

  /// Returns a list of all known currencies (excluding [unknown]).
  static List<Currency> get knownCurrencies =>
      UnmodifiableListView(Currency.values.where((e) => !e.isUnknown).toList());
}
