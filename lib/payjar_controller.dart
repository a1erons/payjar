import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'payjar.dart';

/// {@template pay_jar_controller}
///
/// This is a reusable controller for payjar
///
/// {@endtemplate}
class PayjarController {
  // ========================================================
  // === Fields & Initializers ========================================
  // ========================================================

  /// This is an instruction
  /// for this payment
  final String instruction;

  /// This is your credentials
  final PayjarCredentials credentials;

  /// This is your request
  final PaymentRequest request;

  /// This will be true if controller is busy
  final ValueNotifier<bool> isBusy = ValueNotifier(false);

  /// This is the receiving bank account
  final ValueNotifier<PaymentRequestResponse> _requestResponse = ValueNotifier(
    PaymentRequestResponse.empty(),
  );

  /// This will be called only after a successful payment
  final VoidCallback onPaymentSuccess;

  /// This will be true if controller is disposed
  bool _isDisposed = false;

  PayjarController({
    required this.instruction,
    required this.credentials,
    required this.request,
    required this.onPaymentSuccess,
  }) {
    _attachRequestResponseListener();
  }

  // ========================================================
  // === Getters ========================================
  // ========================================================

  /// Read only value `_requestResponse`
  ValueListenable<PaymentRequestResponse> get requestResponse =>
      _requestResponse;

  /// Request response value from `notifier`
  PaymentRequestResponse get _requestResponseValue => _requestResponse.value;

  // ========================================================
  // === Setters ========================================
  // ========================================================

  /// This set's the value of `isBusy` to a new value
  void _setIsBusyTo(bool to) {
    if (_isDisposed) return;

    if (isBusy.value != to) isBusy.value = to;
  }

  /// This set's `bank transfer to` to a new value
  void _setRequestResponseTo(PaymentRequestResponse to) {
    if (_isDisposed) return;

    if (_requestResponseValue != to) _requestResponse.value = to;
  }

  /// This is a listener attached to `_requestResponse`
  void _requestResponseListener() {
    if (!_requestResponseValue.isEmpty &&
        _requestResponseValue.options?.payment.paymentStatus.isSuccess ==
            true) {
      onPaymentSuccess();
    }
  }

  /// This attache `_requestResponseListener` to `_requestResponse`
  void _attachRequestResponseListener() =>
      _requestResponse.addListener(_requestResponseListener);

  /// This removes listener from `_requestResponse`
  void _removeRequestResponseListener() =>
      _requestResponse.removeListener(_requestResponseListener);

  // ========================================================
  // === Methods ========================================
  // ========================================================

  /// This is for processing payment
  Future<void> pay() async {
    _setIsBusyTo(true);
    _setRequestResponseTo(await _processPayment());
    _setIsBusyTo(false);
  }

  /// This is to start a payment
  Future<PaymentRequestResponse> _processPayment() async {
    final response = await http.post(
      Uri.parse('https://app.supa.cash/supapay/v1/transaction/initialize'),
      headers: {
        'Authorization': 'Bearer ${credentials.secretKey}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap),
    );

    final responseBody =
        jsonDecode(response.body) as Map<String, Object?>? ?? const {};

    final paymentRequestResponse = PaymentRequestResponse.fromMap(responseBody);

    return paymentRequestResponse;
  }

  /// Call to dispose controller
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;

    _removeRequestResponseListener();

    for (final notifier in [isBusy, _requestResponse]) {
      notifier.dispose();
    }
  }
}
