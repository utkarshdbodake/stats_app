import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'package:stats_app/models/transaction_state.dart';
import 'package:stats_app/models/statistics_state.dart';
import 'package:stats_app/dao/stats_dao.dart';

class StatsBloc {

  double amount = 0.0;
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // input streams
  final BehaviorSubject<double> _amountStream = BehaviorSubject<double>();
  final BehaviorSubject _transactionFormSubmitStream = BehaviorSubject();
  final BehaviorSubject _fetchStatsStream = BehaviorSubject();
  Sink<double> get amountSinkStream => _amountStream.sink;
  Sink get transactionFormSubmitStream => _transactionFormSubmitStream.sink;
  Sink get fetchStatsStream => _fetchStatsStream.sink;

  // output streams
  final BehaviorSubject<int> _timestampBehaviourSubject = BehaviorSubject<int>();
  Stream<int> get timestampStream => _timestampBehaviourSubject.stream;
  final BehaviorSubject<StatisticsState> _statisticsBehaviourSubject = BehaviorSubject<StatisticsState>();
  Stream<StatisticsState> get statisticsStream => _statisticsBehaviourSubject.stream;

  StatsBloc() {

    _amountStream.stream.listen((double amount) => this.amount = amount);

    _transactionFormSubmitStream.stream.listen((_) {
      print('Transaction form submitted: ${this.amount}, $timestamp');
      TransactionState transactionState = TransactionState(amount: amount, timestamp: timestamp);
      StatsDao.postTransaction(transactionState).then((_) => print('postTransaction success'));
    });

    _fetchStatsStream.stream.listen((_) {
      print('Fetching stats...');
      StatsDao.getStats().then((StatisticsState statisticsState) {
            _statisticsBehaviourSubject.add(statisticsState);
      });
    });

    // Runs every 1 second to update the timestamp
    Timer.periodic(Duration(seconds:1), (_) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
      _timestampBehaviourSubject.add(timestamp);
    });
  }

  void dispose() {
    _amountStream.close();
    _transactionFormSubmitStream.close();
    _timestampBehaviourSubject.close();
    _fetchStatsStream.close();
    _statisticsBehaviourSubject.close();
  }
}

class StatsProvider extends InheritedWidget {
  final StatsBloc statsBloc;

  StatsProvider(
      {Key key, @required StatsBloc statsBloc, @required Widget child})
      : this.statsBloc = statsBloc ?? StatsBloc(),
        super(key: key, child: child);

  static StatsBloc of(BuildContext context) {
    StatsProvider statsProvider =
        (context.inheritFromWidgetOfExactType(StatsProvider) as StatsProvider);
    return statsProvider.statsBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
