# lunchmoney

A simple to use, asynchronous API wrapper for the [Lunch Money](https://lunchmoney.app/) personal
finance service.

## Features

- [x] Fetch your user profile
- [x] Fetch, create, and update assets
- [x] Fetch, upsert, and remove budgets
- [x] Fetch, create, delete, and update a category
- [x] Create and add to a category group
- [x] Fetch and update crypto assets
- [x] Fetch Plaid accounts
- [x] Fetch recurring expenses
- [x] Fetch tags
- [x] Fetch, insert, update, and unsplit transactions
- [x] Fetch, create, and delete transaction groups

## Getting started

Add this library to your project:

```
dart pub add lunchmoney_dart
```

## Usage

```dart
import 'package:lunchmoney/lunchmoney.dart';

void main() async {
  final client = LunchMoney(ACCESS_TOKEN);

  final user = await client.user.me;
  print(user.userName);
}

```

## Additional information

To learn more about the Lunch Money API, visit the [developer page](https://lunchmoney.dev/).
