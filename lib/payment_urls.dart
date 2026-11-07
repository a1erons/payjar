import 'dart:collection';

/// This holds the URLs required to initialize and display a payment checkout,
/// including the checkout page and the payment integration script.
class PaymentUrls {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// The URL of the payment checkout page.
  ///
  /// This is where the customer completes the payment process.
  final String checkoutUrl;

  /// The URL of the JavaScript payment integration script.
  ///
  /// This script is required to initialize and handle the payment checkout.
  final String scriptUrl;

  /// This creates payment URLs.
  const PaymentUrls({required this.checkoutUrl, required this.scriptUrl});

  /// This creates `payment URLs` from the map provided.
  factory PaymentUrls.fromMap(Map<String, Object?> src) {
    return PaymentUrls(
      checkoutUrl: src["checkout_url"] as String? ?? "",
      scriptUrl: src["script_url"] as String? ?? "",
    );
  }

  /// This creates a new copy of `payment URLs`.
  PaymentUrls copyWith({String? checkoutUrl, String? scriptUrl}) {
    return PaymentUrls(
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      scriptUrl: scriptUrl ?? this.scriptUrl,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `payment URLs` to a map.
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "checkout_url": checkoutUrl,
    "script_url": scriptUrl,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentUrls) return false;

    return checkoutUrl == other.checkoutUrl && scriptUrl == other.scriptUrl;
  }

  @override
  int get hashCode => Object.hash(checkoutUrl, scriptUrl);
}
