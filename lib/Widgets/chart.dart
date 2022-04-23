import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp_02/Models/Transaction.dart';
import './ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;
  final bool isdarkmode;

  Chart(this.recenttransactions, this.isdarkmode);

  double TotalSpending = 0.0;

  List<Map<String, Object>> get GetDataForChart {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0.0;

      for (var i = 0; i < recenttransactions.length; i++) {
        if (recenttransactions[i].date.day == weekday.day &&
            recenttransactions[i].date.month == weekday.month &&
            recenttransactions[i].date.year == weekday.year) {
          totalsum += recenttransactions[i].price;
          TotalSpending += recenttransactions[i].price;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: isdarkmode
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        color: isdarkmode ? Colors.white24 : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: GetDataForChart.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  TotalSpending <= 0
                      ? 0
                      : (data['amount'] as double) / TotalSpending,
                  data['amount'],
                  data['day'],
                  isdarkmode),
            );
          }).toList(),
        ),
      ),
    );
  }
}
