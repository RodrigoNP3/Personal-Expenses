import 'package:flutter/material.dart';

import 'package:expense_planner_rev01/models/transactions.dart';
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
      home: const MyHomePage(title: 'Personal Expenses'),
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
  final List<Transactions> _userTransactions = [
    // Transactions(
    //   id: 'T1',
    //   amount: 69.69,
    //   title: 'Test',
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 'T2',
    //   amount: 24.50,
    //   title: 'Test',
    //   date: DateTime.now(),
    //   //DateFormat.yMMMMEEEEd().format(DateTime.now())
    // ),
  ];
//______________________________________________________________________________void _deletTransaction
  void _deletTRansaction(String _id) {
    setState(() {
      _userTransactions.removeWhere((cx) {
        return cx.id == _id;
      });
    });
  }

//______________________________________________________________________________List _recentTransactionList
  List<Transactions> get _recentTransactionsList {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

//______________________________________________________________________________void _addTransactions
  void _addTransactions(String _title, double _amount, DateTime _selectedDate) {
    setState(() {
      _userTransactions.add(
        Transactions(
          id: DateTime.now().toString(),
          amount: _amount,
          title: _title,
          date: _selectedDate,
        ),
      );
    });
  }

//______________________________________________________________________________appBar
  final appBar = AppBar(
    // actions: [
    //    IconButton(onPressed: () , icon: const Icon(Icons.add)),
    // ],
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
        child: TransactionList(_userTransactions, _deletTRansaction));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar,
//______________________________________________________________________________body
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!isLandscape) ..._buildPortraitContent(mediaQuery, _txList),
                if (isLandscape) ..._buildLandscapeContent(mediaQuery, _txList),
              ],
            ),
          ),
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
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
