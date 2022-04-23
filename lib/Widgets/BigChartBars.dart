import 'package:flutter/material.dart';

class BigChartBar extends StatelessWidget {
  final bool isdarkmode;
  final double pr_of_spending;
  final String day;
  final double spending;

  BigChartBar(this.pr_of_spending, this.spending, this.day, this.isdarkmode);

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
          Flexible(
            child: Container(
              height: constraints.maxHeight * 0.6,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  Container(
                    child: FractionallySizedBox(
                      heightFactor: pr_of_spending,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          decoration: BoxDecoration(
                              color: isdarkmode
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ))),
                    ),
                  ),
                ],
              ),
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
