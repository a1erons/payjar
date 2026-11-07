import '../environment.dart';

/// Extension on [Environment] providing convenient boolean getters for environment checks.
extension EnvironmentExt on Environment {
  /// This will be true if environment is unknown
  bool get isUnknown => this == Environment.unknown;

  /// This will be true if operating in the test/staging environment
  bool get isTest => this == Environment.test;

  /// This will be true if operating in the live/production environment
  bool get isLive => this == Environment.live;
}
