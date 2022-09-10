// import 'dart:math';

import 'package:expense_planner_rev01/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;
  final Function deletTRansaction;

  TransactionList(this.userTransactions, this.deletTRansaction);

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
                            '\$${userTransactions[index].amount.toStringAsFixed(2)}',
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
                      onPressed: () {
                        deletTRansaction(userTransactions[index].id.toString());
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
                    const Text('No Transactions Aded Yet'),
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
