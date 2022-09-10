import 'package:flutter/cupertino.dart';

class Transactions {
  @required
  final double amount;
  @required
  final String id;
  @required
  final String title;
  @required
  final date;

  Transactions({
    this.id = '',
    this.amount = 0,
    this.title = '',
    this.date = '',
  });
}
