import 'package:intl/intl.dart';

import 'package:expense_planner_rev01/models/expense_model.dart';
import 'package:expense_planner_rev01/widgets/chart_bar.dart';

import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentTransactions;
  Chart(
    this.recentTransactions,
  );

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : ((data['amount'] as double) / totalSpending),
                  data['day'] as String,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
