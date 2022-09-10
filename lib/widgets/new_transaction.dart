import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  @required
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime(00, 00, 00);

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        enteredAmount == 0 ||
        enteredAmount == null ||
        _selectedDate == DateTime(00, 00, 00)) {
      return;
    }
    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Container(
        padding: mediaQueryData.viewInsets,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: const Center(
                  child: Text(
                    'New Transaction',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
            ]),
            TextField(
              controller: _titleController,
              autocorrect: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.title_rounded),
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              //onSubmitted: (_) => _submitData(),
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money_rounded),
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            GestureDetector(
              onTap: () {
                _presentDatePicker();
              },
              child: Card(
                margin: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 10,
                ),
                //elevation: 5,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const Icon(Icons.calendar_month),
                    ),
                    Container(
                      child: Text(_selectedDate == DateTime(00, 00, 00)
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMMMMEEEEd().format(_selectedDate)}'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              width: double.infinity,
              child: TextButton(
                onPressed: () => _submitData(),
                child: const Text('ADD TRANSACTION'),
              ),
            ),
          ],
        ),
      ),
      //card
    );
  }
}
