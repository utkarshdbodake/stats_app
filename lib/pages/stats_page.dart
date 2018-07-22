import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_buttons/flutter_buttons.dart';

import 'package:stats_app/models/statistics_state.dart';
import 'package:stats_app/blocs/stats_bloc.dart';

class StatsMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatsBloc statsBloc = StatsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Stats App'),
          centerTitle: true,
          backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                getTransactionWidget(statsBloc),
                SizedBox(height: 30.0),
                Divider(color: Colors.teal),
                SizedBox(height: 30.0),
                getStatsResponseWidget(statsBloc)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTransactionWidget(StatsBloc statsBloc) {
    List colors = [Colors.teal, Colors.green, Colors.blue, Colors.black, Colors.orange];

    return Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: <Widget>[
            Text(
              'Amount: ',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            SizedBox(
              width: 30.0,
            ),
            Expanded(
              child: TextField(
                onChanged: (text) => statsBloc.amountSinkStream.add(double.parse(text)),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter transaction amount',
                  hintText: '30.5',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: <Widget>[
            Text(
              'Timestamp: ',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            SizedBox(
              width: 30.0,
            ),
            StreamBuilder<int>(
              initialData: statsBloc.timestamp,
              stream: statsBloc.timestampStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                int index = new Random().nextInt(colors.length);
                return Expanded(
                  child: Text(
                    '${snapshot.data}',
                    style: TextStyle(
                        color: colors[index],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        KRaisedButton(
          minWidth: 80.0,
          radius: 30.0,
          color: Colors.teal,
          text: 'Add transaction',
          textColor: Colors.white,
          onPressed: () {
            print('Add transaction pressed');
            statsBloc.transactionFormSubmitStream.add(null);
          },
        ),
      ],
    );
  }

  Widget getStatsNumbers(StatsBloc statsBloc) {
    List colors = [Colors.teal, Colors.green, Colors.blue, Colors.black, Colors.orange];

    return StreamBuilder<StatisticsState>(
        initialData: StatisticsState.initial(),
        stream: statsBloc.statisticsStream,
        builder: (BuildContext context, AsyncSnapshot<StatisticsState> snapshot) {
          int index = new Random().nextInt(colors.length);
          return Column(
            children: <Widget>[
              Text(
                'Sum: ${snapshot.data.sum}',
                style: TextStyle(
                    color: colors[index],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Avg: ${snapshot.data.avg}',
                style: TextStyle(
                    color: colors[index],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Max: ${snapshot.data.max}',
                style: TextStyle(
                    color: colors[index],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Min: ${snapshot.data.min}',
                style: TextStyle(
                    color: colors[index],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Count: ${snapshot.data.count}',
                style: TextStyle(
                    color: colors[index],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ],
          );
        }
    );
  }

  Widget getLoadingStatus() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100.0,
          child: LinearProgressIndicator(),
        ),
        SizedBox(height: 20.0),
        Text(
          'Loading...',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        )
      ],
    );
  }


  Widget getStatsResponseWidget(StatsBloc statsBloc) {
    List colors = [Colors.teal, Colors.green, Colors.blue, Colors.black, Colors.orange];

    return StreamBuilder<StatisticsState>(
        initialData: StatisticsState.initial(),
        stream: statsBloc.statisticsStream,
        builder: (BuildContext context, AsyncSnapshot<StatisticsState> snapshot) {
          int index = new Random().nextInt(colors.length);

          return Column(
            children: <Widget>[
              Text(
                'Statistics',
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              StreamBuilder<bool>(
              initialData: false,
              stream: statsBloc.isLoadingStateStream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Stack(
                  children: <Widget>[
                    Center(
                      child: Opacity(
                        opacity: snapshot.data ? 0.0 : 1.0,
                        child: getStatsNumbers(statsBloc),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 60.0),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: snapshot.data ? 1.0 : 0.0,
                            child: getLoadingStatus(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 20.0,
              ),
              KRaisedButton(
                minWidth: 80.0,
                radius: 30.0,
                color: Colors.teal,
                text: 'Fetch Statsistics',
                textColor: Colors.white,
                onPressed: () {
                  print('Fetch stats pressed');
                  statsBloc.fetchStatsStream.add(null);
                },
              ),
            ],
          );
        },
    );
  }
}
