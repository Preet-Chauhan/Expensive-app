import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Transaction{
final String title;
final double price;
final String id;
final DateTime date;

Transaction({
  @required this.title,
  @required this.id,
  @required this.price,
  @required this.date});

}