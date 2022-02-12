import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime(1900);

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount < 0) return;
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == DateTime(1900)) {
        return;
      }
      setState(() {
        _selectedDate = pickDate!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onChanged: (_) => _submitData,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: (_) => _submitData,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    _selectedDate == DateTime(1900)
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                  ),
                  Expanded(
                    flex: 4,
                    child: TextButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Choose Date'),
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerRight,
                          primary: Theme.of(context).primaryColor,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add Transaction'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
