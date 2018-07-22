
class TransactionState {
  final String amount;
  final int timestamp = DateTime.now().millisecondsSinceEpoch;

  TransactionState({ this.amount });

  @override
  String toString() => '''
    Transaction {
      amount: $amount,
      timestamp: $timestamp
    }
  ''';
}
