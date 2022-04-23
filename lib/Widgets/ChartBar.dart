import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final bool isdarkmode;
  final double pr_of_spending;
  final String day;
  final double spending;

  ChartBar(this.pr_of_spending, this.spending, this.day, this.isdarkmode);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(constraints.maxHeight * 0.025),
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${spending.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isdarkmode ? Colors.white : Colors.black),
                ),
              )),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isdarkmode ? Colors.white : Colors.grey,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                    color: isdarkmode
                        ? Colors.white
                        : Color.fromRGBO(220, 220, 220, 10),
                  ),
                ),
                Container(
                  child: FractionallySizedBox(
                    heightFactor: pr_of_spending,
                    child: Container(
                      decoration: BoxDecoration(
                          color: isdarkmode
                              ? Theme.of(context).accentColor
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(constraints.maxHeight * 0.025),
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text(day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isdarkmode ? Colors.white : Colors.black))),
          )
        ],
      );
    });
  }
}
