# Payjar

[![GitHub](https://img.shields.io/badge/github-a1erons%2Fpayjar-blue?logo=github)](https://github.com/a1erons/payjar)

A Flutter package for accepting **bank transfer payments** inside your app, backed by the Supa.cash payment API.

Payjar gives you a ready-made payment UI plus a lightweight controller, and a fully typed model layer for requests, responses, payment breakdowns, bank transfer details, timestamps and checkout URLs.

## Features

- **Drop-in payment UI** — `PayWithPayjar` renders the instructions, receiving bank account and a confirmation button out of the box.
- **Reusable controller** — `PayjarController` handles initialization, busy state and success callbacks.
- **Customizable builders** — Swap out the body, instructions, bank transfer info, confirmation button or loader with your own widgets.
- **Strongly typed models** — `PaymentRequest`, `PaymentRequestResponse`, `PayjarPayment`, `PaymentBreakdown`, `PaymentTimestamps`, `PaymentUrls` and `BankTransferTo`.
- **Typed enums + extensions** — `Currency`, `Environment`, `FeePaidBy` and `PaymentStatus`, each with convenient boolean getters.
- **Map serialization** — Every model converts to and from maps for easy persistence and testing.
- **Equality built in** — All models implement `==` and `hashCode`.

## Requirements

- Flutter
- Dart SDK `3.11.4` or later

## Installation

Add Payjar to your project's `pubspec.yaml`:

```yaml
dependencies:
  payjar:
    git:
      url: https://github.com/a1erons/payjar.git
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:payjar/payjar.dart';
```

### 1. Build a payment request

```dart
final request = PaymentRequest(
  // Amount in the smallest currency unit (e.g. kobo for NGN, cents for USD).
  amount: 500000,
  reference: 'ORDER-1234',
  currency: Currency.ngn,
  feePaidBy: FeePaidBy.merchant,
  metadata: const {'orderId': '1234'},
  customerDetails: const CustomerDetails(
    id: 1,
    email: 'jane@example.com',
    name: 'Jane Doe',
    phone: '+2348012345678',
  ),
);
```

### 2. Create a controller

```dart
final controller = PayjarController(
  instruction: 'Please transfer the exact amount to the account below.',
  credentials: const PayjarCredentials(
    publicKey: 'your_public_key',
    secretKey: 'your_secret_key',
  ),
  request: request,
  onPaymentSuccess: () {
    // Called automatically once the payment status becomes `success`.
    debugPrint('Payment received!');
  },
);
```

### 3. Render the payment screen

```dart
PayWithPayjar(controller: controller);
```

`PayWithPayjar` automatically triggers `controller.pay()` after the first frame and rebuilds the bank transfer details and button as the controller state changes.

### 4. Clean up

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

## Customization

Every part of the default UI can be replaced through optional builders:

```dart
PayWithPayjar(
  controller: controller,
  // Replace the entire body.
  bodyBuilder: (children) => Column(children: children),
  // Replace the instruction text.
  instructionBuilder: (instruction) => Text(instruction),
  // Replace the receiving bank account block.
  bankTransferInfoBuilder: (BankTransferTo bank) => Text(bank.accountNumber),
  // Replace the confirmation button.
  confirmationButtonBuilder: (pay) => ElevatedButton(
    onPressed: pay,
    child: const Text('I have paid'),
  ),
  // Replace the loading indicator.
  loaderBuilder: () => const CircularProgressIndicator(),
  // Handle copying the account number yourself.
  copyAccountNumber: (value) => Clipboard.setData(ClipboardData(text: value)),
);
```

## Controller API

| Member | Type | Description |
| --- | --- | --- |
| `instruction` | `String` | Instruction shown to the payer. |
| `credentials` | `PayjarCredentials` | Your public and secret keys. |
| `request` | `PaymentRequest` | The payment to initialize. |
| `isBusy` | `ValueListenable<bool>` | `true` while a request is in flight. |
| `requestResponse` | `ValueListenable<PaymentRequestResponse>` | Latest response from the API. |
| `onPaymentSuccess` | `VoidCallback` | Fired when the payment status is `success`. |
| `pay()` | `Future<void>` | Initializes / refreshes the payment request. |
| `dispose()` | `void` | Releases the controller's notifiers. |

## Models

- `PaymentRequest` — amount, reference, currency, fee payer, metadata and customer details.
- `PaymentRequestResponse` — `isSuccess`, `message` and optional request `options`.
- `PayjarRequestOptions` — the `payment` payload plus `notificationCount`.
- `PayjarPayment` — id, access code, environment, status, nested request, breakdown, timestamps, URLs and bank details.
- `PaymentBreakdown` — `fee`, `chargedAmount` and `settledAmount`.
- `PaymentTimestamps` — `createdAt`, `expiresAt` and `paidAt`.
- `PaymentUrls` — `checkoutUrl` and `scriptUrl`.
- `BankTransferTo` — `accountName`, `accountNumber`, `bankName`, `bankLogoUrl` and `isAvailable`.
- `CustomerDetails` — customer `id`, `email`, `name` and `phone`.
- `PayjarCredentials` — `publicKey` and `secretKey`.

## Enums

| Enum | Values |
| --- | --- |
| `Currency` | `unknown`, `usd`, `eur`, `gbp`, `ngn`, `cad`, `aud`, `jpy` |
| `Environment` | `unknown`, `test`, `live` |
| `FeePaidBy` | `unknown`, `customer`, `merchant` |
| `PaymentStatus` | `unknown`, `awaitingTransfer`, `pending`, `success`, `expired`, `failed`, `cancelled` |

Each enum exposes a `fromValue(...)` factory and a `known*` list, plus boolean getters via extensions (for example `status.isSuccess`, `currency.isNgn`, `environment.isLive`).

## API Documentation

For information about the underlying payment service, visit:

https://www.payjar.net/

## Issues and Contributions

Bug reports, feature requests and contributions are welcome. Please use the GitHub repository's issue tracker to report problems or suggest improvements.

## License

Payjar is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

Developed and maintained by **Moses Dike Okore**.

- GitHub: [@a1erons](https://github.com/a1erons)
