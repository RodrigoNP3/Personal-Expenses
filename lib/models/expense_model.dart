import 'package:flutter/cupertino.dart';

const String tableExpenses = 'expenses';

class ExpenseFields {
  static final List<String> values = [
    /// Add all fields
    id, amount, title, date,
  ];

  static String id = '_id';
  static String amount = 'amount';
  static String title = 'title';
  static String date = 'date';
}

class Expense {
  final int? id;
  final double amount;
  final String title;
  final DateTime date;

  const Expense({
    this.id,
    required this.amount,
    required this.title,
    required this.date,
  });

  Expense copy({
    int? id,
    double? amount,
    String? title,
    DateTime? date,
  }) =>
      Expense(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        title: title ?? this.title,
        date: date ?? this.date,
      );

  static Expense fromJson(Map<String, Object?> json) => Expense(
        id: json[ExpenseFields.id] as int?,
        amount: json[ExpenseFields.amount] as double,
        title: json[ExpenseFields.title] as String,
        date: DateTime.parse(json[ExpenseFields.date] as String),
      );

  Map<String, Object?> toJson() => {
        ExpenseFields.id: id,
        ExpenseFields.title: title,
        ExpenseFields.amount: amount,
        ExpenseFields.date: date.toIso8601String(),
      };
}
