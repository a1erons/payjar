import 'dart:collection';
import 'extensions/environment_ext.dart';

/// {@template environment}
///
/// Specifies the operational environment or deployment stage for an application
/// or service integration.
///
/// Distinguishes between sandbox/staging testing ([test]) and production ([live])
/// environments, ensuring secure credential routing and appropriate API behavior.
///
/// {@endtemplate}
enum Environment {
  /// Fallback value for unrecognized, missing, or uninitialized environment configurations.
  unknown,

  /// Sandbox, staging, or testing environment.
  test,

  /// Production or live environment.
  live;

  /// Creates an [Environment] enum from the provided [value].
  ///
  /// Falls back to [Environment.unknown] if the input is unrecognized or null.
  factory Environment.fromValue(Object? value) {
    return values.firstWhere(
      (e) =>
          e.name.toLowerCase() == (value as String? ?? "").trim().toLowerCase(),
      orElse: () => unknown,
    );
  }

  /// Returns a list of all known environments (excluding [unknown]).
  static List<Environment> get knownEnvironments => UnmodifiableListView(
    Environment.values.where((e) => !e.isUnknown).toList(),
  );
}
