import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:stats_app/models/transaction_state.dart';
import 'package:stats_app/models/statistics_state.dart';
import 'package:stats_app/constants/constants.dart' as constants;

class StatsDao {
  static final http.Client _httpClient = http.Client();
  static final String _statsAPI = '${constants.statsAPI}';

  static Future postTransaction(TransactionState transactionState) async {
    return _httpClient
        .post(Uri.parse('$_statsAPI/transactions'),
            body: json.encode(transactionState))
        .catchError((error) => print('Error while postTransaction'));
  }

  static Future<StatisticsState> getStats() async {
    return _httpClient
        .get(Uri.parse('$_statsAPI/statistics'))
        .then((res) => res.body)
        .then(json.decode)
        .then((data) => StatisticsState.fromJSON(data))
        .catchError((error) => StatisticsState.initial());
  }
}
