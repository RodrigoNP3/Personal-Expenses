import 'package:expense_planner_rev01/test_page.dart';
import 'package:expense_planner_rev01/database/expenses_database.dart';
import 'package:flutter/material.dart';

import 'package:expense_planner_rev01/models/expense_model.dart';
import 'package:expense_planner_rev01/widgets/transactions_list.dart';
import 'package:expense_planner_rev01/widgets/new_transaction.dart';
import 'package:expense_planner_rev01/widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green, // Theme Color
        accentColor: Colors.indigo,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              // button: TextStyle(color: Colors.white),
            ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Personal Expenses'),
      // home: TestPage(),
    );
  }
}

//______________________________________________________________________________class MyHomePage StatefullWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//______________________________________________________________________________class _MyHomePageState
class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;
  List<Expense> _userTransactions = [];
  bool isLoading = false;

  void _fetchAndSetData() async {
    setState(() {
      isLoading = true;
    });
    _userTransactions = await ExpensesDatabase.instance.readAllExpense();
    setState(() {
      isLoading = false;
    });
  }

//______________________________________________________________________________List _recentTransactionList
  List<Expense> get _recentTransactionsList {
    return _userTransactions.where((tx) {
      final transactionDate = DateTime.parse(tx.date.toString());
      return transactionDate.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    _fetchAndSetData();
    super.initState();
  }

//______________________________________________________________________________void _addTransactions
  void _addTransactions(String _title, double _amount, DateTime _selectedDate) {
    var Id = DateTime.now().toString();
    Expense expense = Expense(
      amount: _amount,
      title: _title,
      date: _selectedDate,
    );
    ExpensesDatabase.instance.create(expense);
    _fetchAndSetData();
  }

  //______________________________________________________________________________void _removeTransactions
  void _removeTransactions(int id) {
    ExpensesDatabase.instance.delete(id);
    _fetchAndSetData();
  }

//______________________________________________________________________________appBar
  final appBar = AppBar(

    title: const Text(
      'Personal Expenses',
      style: TextStyle(fontFamily: 'OpenSans'),
    ),
  );

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    _txList,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(_recentTransactionsList),
      ),
      _txList,
    ];
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    _txList,
  ) {
    return [
      Container(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Show Chart'),
            Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                }),
          ],
        ),
      ),
      if (isSwitched)
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7,
          child: Chart(_recentTransactionsList),
        ),
      if (!isSwitched) _txList,
    ];
  }

//______________________________________________________________________________Widget build
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _removeTransactions));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar,
//______________________________________________________________________________body
        body: !isLoading
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!isLandscape)
                        ..._buildPortraitContent(mediaQuery, _txList),
                      if (isLandscape)
                        ..._buildLandscapeContent(mediaQuery, _txList),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (BuildContext context) {
                return NewTransaction(_addTransactions);
              },
            ),
            _fetchAndSetData(),
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
