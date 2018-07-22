import 'package:flutter/material.dart';

import 'package:stats_app/blocs/stats_bloc.dart';
import 'package:stats_app/themes/default_theme.dart';
import 'package:stats_app/pages/stats_page.dart';

void main() {
  runApp(SupportWheelApp());
}

class SupportWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatsProvider(
      statsBloc: StatsBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: defaultTheme,
        title: 'Stats App',
        home: StatsMainPage(),
      ),
    );
  }
}
