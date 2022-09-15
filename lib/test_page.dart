// import 'package:flutter/material.dart';
// import 'database/expenses_database.dart';
// import 'models/expense_model.dart';
// import 'package:sqflite/sqflite.dart';

// class TestPage extends StatefulWidget {
//   // const TestPage({Key? key}) : super(key: key);

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   List<Expense> expenses = [];

//   Future readExpenses() async {
//     expenses = await ExpensesDatabase.instance.readAllExpense();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TestPage'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 // ExpenseDatabase.instance.close();
//                 // getdata();
//               },
//               icon: const Icon(Icons.clear)),
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   print('clicked');
//                   Expense expense = Expense(
//                     amount: 50.50,
//                     title: 'This is a test',
//                     date: DateTime.now(),
//                   );
//                   print('Expense created');
//                   ExpensesDatabase.instance.create(expense);
//                   print('Expense Added');
//                   readExpenses();
//                 });
//               },
//               icon: const Icon(Icons.add))
//         ],
//       ),
//       body: Container(
//         height: double.maxFinite,
//         child: expenses.isNotEmpty
//             ? ListView.builder(
//                 itemCount: expenses.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: double.maxFinite,
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             Text(expenses[index].title),
//                             Text(expenses[index].amount.toString()),
//                             Text(expenses[index].id.toString()),
//                             Text(expenses[index].date.toString()),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () async {
//                               await ExpensesDatabase.instance
//                                   .delete(expenses[index].id as int);
//                               readExpenses();
//                             },
//                             icon: const Icon(Icons.delete))
//                       ],
//                     ),
//                   );
//                 },
//               )
//             : const Text('NO TRANSACTIONS FOUND'),
//       ),
//     );
//   }
// }
