import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransInput extends StatefulWidget {
  final Function _addTrans;

  TransInput(this._addTrans);

  @override
  _TransInputState createState() => _TransInputState();
}

class _TransInputState extends State<TransInput> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime SelectedDate;

  void SubmitData() {
    if (amountcontroller.text.isEmpty) return;

    String title = titlecontroller.text;
    double amount = double.parse(amountcontroller.text);

    if (title.isEmpty || amount <= 0 || SelectedDate == null) return;

    widget._addTrans(title, amount, SelectedDate);

    Navigator.of(context).pop();
  }

  void presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null)
        return;
      else {
        setState(() {
          SelectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
                child: Container(
              width: 70,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.black54)),
            )),
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titlecontroller,
              onSubmitted: (_) => SubmitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => SubmitData,
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      SelectedDate == null
                          ? 'No date Selected'
                          : 'Picked date : ${DateFormat.yMd().format(SelectedDate)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      presentDate();
                    },
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: SubmitData,
              child: Text(
                'Add Transaction',
                style:
                    TextStyle(color: Theme.of(context).textTheme.button.color),
              ),
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
