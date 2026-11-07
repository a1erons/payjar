/*Recently reviewed, revised and optimized on Fri April 4th, 2025*/

import 'package:flutter/material.dart';
import 'payjar.dart';

class PayWithPayjar extends StatefulWidget {
  /// This is your payjar controller
  final PayjarController controller;

  /// Use when you want to customize the entire body of your
  /// `payjar` ui
  final Widget? Function(List<Widget> _)? bodyBuilder;

  /// Use when you want to customize instructions ui
  final Widget? Function(String _)? instructionBuilder;

  /// Use when you want to customize bank transfer instruction
  final Widget? Function(BankTransferTo _)? bankTransferInfoBuilder;

  /// Use when you want to customize action button
  final Widget? Function(Future<void> _)? confirmationButtonBuilder;

  /// Use when you want to customize loader
  final Widget? Function()? loaderBuilder;

  /// Call to copy account number to clipboard
  final Function(String _)? copyAccountNumber;

  /// This creates a `PayWithPayjar`
  const PayWithPayjar({
    super.key,
    required this.controller,
    this.bodyBuilder,
    this.instructionBuilder,
    this.bankTransferInfoBuilder,
    this.confirmationButtonBuilder,
    this.loaderBuilder,
    this.copyAccountNumber,
  });

  @override
  State<PayWithPayjar> createState() => _PayWithPayjarState();
}

class _PayWithPayjarState extends State<PayWithPayjar> {
  /// Instance of controller from widget
  PayjarController get _controller => widget.controller;

  /// Call on page init
  Future<void> _onInit() async =>
      WidgetsBinding.instance.addPostFrameCallback((_) => _controller.pay());

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.bodyBuilder?.call(_buildChildren()) ?? _buildBody();
  }

  /// This builds the entire pay jar body
  Widget _buildBody() {
    return Material(child: Column(children: _buildChildren()));
  }

  /// This builds the children of this page
  List<Widget> _buildChildren() {
    return [
      _buildInstruction(),

      _buildBankTransferInfo(),

      _buildConfirmationButton(),
    ];
  }

  /// This builds the instruction
  Widget _buildInstruction() {
    final instruction = _controller.instruction;

    return widget.instructionBuilder?.call(instruction) ??
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
            bottom: 5,
            top: 20,
          ),
          child: Text(instruction),
        );
  }

  /// This builds bank transfer info
  Widget _buildBankTransferInfo() {
    return ValueListenableBuilder(
      valueListenable: _controller.requestResponse,
      builder: (_, response, _) {
        final bankTransferTo = response.options?.payment.bankTransferTo;

        if (bankTransferTo == null) return const SizedBox();

        final amount = _controller.request.amount ~/ 10000;
        final currency = _controller.request.currency.name.toUpperCase();
        final accountName = bankTransferTo.accountName;
        final accountNumber = bankTransferTo.accountNumber;
        final bankName = bankTransferTo.bankName;
        final bankLogoUrl = bankTransferTo.bankLogoUrl;

        final textStyle = const TextStyle(color: Colors.grey);

        return widget.bankTransferInfoBuilder?.call(bankTransferTo) ??
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: Row(
                children: [
                  if (bankLogoUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        bankLogoUrl,
                        width: 40,
                        cacheHeight: 111,
                        errorBuilder: (_, _, _) => SizedBox.shrink(),
                      ),
                    ),

                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount: $currency ${amount * 100}",
                            style: textStyle.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          if (bankName.isNotEmpty)
                            Text(bankName, style: textStyle),

                          if (accountNumber.isNotEmpty)
                            Text(
                              "Account Number: $accountNumber",
                              style: textStyle,
                            ),

                          if (accountName.isNotEmpty)
                            Text(
                              "Account Name: $accountName",
                              style: textStyle,
                            ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  GestureDetector(
                    onTap: () => widget.copyAccountNumber?.call(
                      "${_controller.request.amount}",
                    ),
                    child: const Icon(Icons.content_copy, color: Colors.grey),
                  ),
                ],
              ),
            );
      },
    );
  }

  /// This builds confirmation button
  Widget _buildConfirmationButton() {
    return ValueListenableBuilder(
      valueListenable: _controller.isBusy,
      builder: (_, isBusy, _) {
        return isBusy
            ? widget.loaderBuilder?.call() ?? _buildLoader()
            : widget.confirmationButtonBuilder?.call(_controller.pay()) ??
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      onPressed: () => _controller.pay(),
                      child: Text("I have paid"),
                    ),
                  );
      },
    );
  }

  Widget _buildLoader() {
    return Text("Please wait...");
  }
}
