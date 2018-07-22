import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'package:stats_app/models/statistics_state.dart';
import 'package:stats_app/dao/stats_dao.dart';

class StatsBloc {

  StatsBloc() {}

  void dispose() {}
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
