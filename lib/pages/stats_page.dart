import 'package:flutter/material.dart';

import 'package:stats_app/blocs/stats_bloc.dart';

class StatsMainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    StatsBloc scheduleBloc = StatsProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
