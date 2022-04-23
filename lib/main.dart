import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './Models/Transaction.dart';

import './Widgets/Input_Trans.dart';
import './Widgets/Transaction_list.dart';
import './Widgets/chart.dart';
import './Widgets/BigChart.dart';

void main() {
  runApp(MyApp());
}

bool isdarkmode = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.black)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'QuickSand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))),
      title: 'Project Beta',
      home: MyHomeUI(),
    );
  }
}

class MyHomeUI extends StatefulWidget {
  @override
  _MyHomeUIState createState() => _MyHomeUIState();
}

class _MyHomeUIState extends State<MyHomeUI> {
  bool showchartstate = true;
  final List<Transaction> transactions = [];

  void _addTrans(String title, double price, DateTime ChosenDate) {
    final NewTx = Transaction(
      title: title,

      id: DateTime.now().toString(),
      price: price,
      date: ChosenDate,
    );

    setState(() {
      transactions.add(NewTx);
    });
  }

  List<Transaction> get recenttransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void ShowDetailedChart(ctx) {
    showModalBottomSheet(
      backgroundColor: isdarkmode ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: BigChart(recenttransactions, isdarkmode),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void StartAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: TransInput(_addTrans),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void DeleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text('Project Beta'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.swap_horizontal_circle_outlined),
            onPressed: () {
              setState(() {

                isdarkmode ? isdarkmode = false : isdarkmode = true;
              });
            }),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => StartAddTransaction(context))
      ],
    );
    return Scaffold(
      backgroundColor: isdarkmode ? Colors.black : Colors.white,
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (islandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show Chart',
                      style: TextStyle(
                          color: isdarkmode ? Colors.white : Colors.black,
                          fontFamily: 'QuickSand'),
                    ),
                    Switch(
                      value: showchartstate,
                      onChanged: (val) {
                        setState(() {
                          showchartstate = val;
                        });
                      },
                    ),
                  ],
                ),
              if (!islandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: GestureDetector(
                    child: Chart(recenttransactions, isdarkmode),
                    onTap: () {
                      ShowDetailedChart(context);
                    },
                  ),
                ),
              if (!islandscape)
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransactionList(
                        transactions, DeleteTransaction, isdarkmode)),
              if (islandscape)
                showchartstate
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: GestureDetector(
                          child: Chart(recenttransactions, isdarkmode),
                          onTap: () {
                            ShowDetailedChart(context);
                          },
                        ),
                      )
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: TransactionList(
                            transactions, DeleteTransaction, isdarkmode)),
            ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: isdarkmode
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () => StartAddTransaction(context),
        //backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
