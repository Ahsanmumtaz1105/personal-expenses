import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';
import './../models/transactions.dart';

// ignore: use_key_in_widget_constructors
class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  // ignore: use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: 10,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 200,
                  child: Image.asset('assets/image/waiting.png'),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        child: FittedBox(
                          child: Text(
                              transactions[index].amount.toStringAsFixed(2)),
                        ),
                        padding: const EdgeInsets.all(4),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(ctx).textTheme.headline2),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(ctx).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              }),
    );
  }
}
