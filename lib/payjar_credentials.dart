import 'dart:collection';

/// {@template pay_jar_credentials}
///
/// This holds your payjar keys in place
///
/// {@endtemplate}
class PayjarCredentials {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// This is your pay jar public key
  final String publicKey;

  /// This is your pay jar private key
  final String secretKey;

  /// This creates a `pay jar credentials` instance
  const PayjarCredentials({required this.publicKey, required this.secretKey});

  /// This creates `pay jar credentials` from map provided
  factory PayjarCredentials.fromMap(Map<String, Object?> src) {
    return PayjarCredentials(
      publicKey: src["publicKey"] as String? ?? "",
      secretKey: src["secretKey"] as String? ?? "",
    );
  }

  /// This creates a new copy of `pay jar credentials`
  PayjarCredentials copyWith({String? publicKey, String? secretKey}) {
    return PayjarCredentials(
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `pay jar credentials` to a map
  Map<String, Object?> get toMap =>
      UnmodifiableMapView({"publicKey": publicKey, "secretKey": secretKey});

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayjarCredentials) return false;

    return publicKey == other.publicKey && secretKey == other.secretKey;
  }

  @override
  int get hashCode => Object.hash(publicKey, secretKey);
}
