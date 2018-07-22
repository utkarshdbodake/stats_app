
class TransactionState {
  final double amount;
  final int timestamp;

  TransactionState({ this.amount, this.timestamp });

  static Map<String, dynamic> toJSON(TransactionState transactionState) {
    return {
      'amount': transactionState.amount,
      'timestamp': transactionState.timestamp,
    };
  }

  @override
  String toString() => '''
    Transaction {
      amount: $amount,
      timestamp: $timestamp
    }
  ''';
}
