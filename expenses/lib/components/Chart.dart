import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get _groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.00;

      for (var i = 0; i < recentTransaction.length; i++) {
        int diffDays = weekDay.difference(recentTransaction[i].date).inDays;
        bool isSame = (diffDays == 0);

        if (isSame && (weekDay.day == recentTransaction[i].date.day)) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  double get _weekTotalValue {
    return _groupedTransaction.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _groupedTransaction.reversed.map((tr) {
          return Flexible(
            fit: FlexFit.tight,
                    child: ChartBar(
              label: tr['day'],
              value: tr['value'],
              percentage: (tr['value'] as double) / _weekTotalValue,
            ),
          );
        }).toList()),
      ),
    );
  }
}
