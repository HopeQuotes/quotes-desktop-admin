import 'package:admin/models/quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuoteItemWidget extends StatelessWidget {
  final Quote _quote;

  @override
  Widget build(BuildContext context) {
    return ListTile();
  }

  const QuoteItemWidget({
    required Quote quote,
  }) : _quote = quote;
}
