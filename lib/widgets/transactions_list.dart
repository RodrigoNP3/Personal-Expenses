// import 'dart:math';

import 'dart:ffi';

import 'package:expense_planner_rev01/models/expense_model.dart';
import 'package:expense_planner_rev01/database/expenses_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/expenses_database.dart';

class TransactionList extends StatelessWidget {
  List<Expense> userTransactions = [];
  Function removeTransactions;

  TransactionList(
    this.userTransactions,
    this.removeTransactions,
  );

  @override
  Widget build(BuildContext context) {
    return userTransactions.isNotEmpty
        ? Container(
            //height: 300,
            child: ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '\$${userTransactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    subtitle: Text(DateFormat.yMMMMEEEEd()
                        .format(userTransactions[index].date)),
                    trailing: IconButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        removeTransactions(userTransactions[index].id as int);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            child: LayoutBuilder(
              builder: ((context, constraints) {
                return Column(
                  children: <Widget>[
                    const Text('No Expenses Added Yet'),
                    const SizedBox(height: 10),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
  }
}
