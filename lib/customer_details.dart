import 'dart:collection';

/// {@template details}
///
/// This holds the personal details of a customer.
///
/// {@endtemplate}
class CustomerDetails {
  // ========================================================
  // === Fields ========================================
  // ========================================================

  /// The unique ID of the customer.
  final int id;

  /// The email address of the customer.
  final String email;

  /// The full name of the customer.
  final String name;

  /// The phone number of the customer.
  final String phone;

  /// This creates customer details.
  const CustomerDetails({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  /// This creates `customer details` from the map provided.
  factory CustomerDetails.fromMap(Map<String, Object?> src) {
    return CustomerDetails(
      id: src["id"] as int? ?? 0,
      email: src["email"] as String? ?? "",
      name: src["name"] as String? ?? "",
      phone: src["phone"] as String? ?? "",
    );
  }

  /// This creates a new copy of `customer details`.
  CustomerDetails copyWith({
    int? id,
    String? email,
    String? name,
    String? phone,
  }) {
    return CustomerDetails(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  // ========================================================
  // === Getters =============================================
  // ========================================================

  /// This converts `customer details` to a map.
  Map<String, Object?> get toMap => UnmodifiableMapView({
    "id": id,
    "email": email,
    "name": name,
    "phone": phone,
  });

  // ========================================================
  // === Equality ============================================
  // ========================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerDetails) return false;

    return id == other.id &&
        email == other.email &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode => Object.hash(id, email, name, phone);
}
