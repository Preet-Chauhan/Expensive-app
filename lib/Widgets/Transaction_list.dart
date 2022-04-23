import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp_02/Models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function DeleteTrans;
  final bool isdarkmode;

  TransactionList(this.transactions, this.DeleteTrans, this.isdarkmode);
  void PopUpForDelete(index, context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content:
            const Text('Are you sure you want to delete this transaction ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              DeleteTrans(transactions[index].id);
              Navigator.pop(context, 'OK');
            },
            child: const Text('okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: constrains.maxHeight * 0.05,
                ),
                Container(
                  height: constrains.maxHeight * 0.1,
                  child: Text('No transactions added yet!',
                      style: isdarkmode
                          ? TextStyle(
                              color: Colors.white,
                              fontFamily: 'QuickSand',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                          : Theme.of(context).textTheme.title),
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.05,
                ),
                Container(
                    height: constrains.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: constrains.maxHeight * 0.3,
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                color: isdarkmode ? Colors.white70 : Colors.white,
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: isdarkmode
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColor,
                    foregroundColor: isdarkmode ? Colors.black : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${transactions[index].price}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          label: Text('Delete'),
                          textColor: Colors.red,
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () => PopUpForDelete(index, context),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () => PopUpForDelete(index, context),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

// Center(child: Text('Last 7 day\'s spendings',style: Theme.of(context).textTheme.title,),),
