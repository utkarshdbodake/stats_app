import 'package:flutter/material.dart';

import 'package:flutter_buttons/flutter_buttons.dart';
import 'package:stats_app/blocs/stats_bloc.dart';

class StatsMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatsBloc scheduleBloc = StatsProvider.of(context);

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
                getTransactionWidget(),
                SizedBox(height: 30.0),
                Divider(color: Colors.teal),
                SizedBox(height: 30.0),
                getStatsResponseWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTransactionWidget() {
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
            Expanded(
              child: Text(
                '452343214523423',
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
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
          },
        ),
      ],
    );
  }


  Widget getStatsResponseWidget() {
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
        Text(
          'Sum: 34',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Avg: 21',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Max: 52',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Min: 5',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Count: 1',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
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
          },
        ),
      ],
    );
  }
}
