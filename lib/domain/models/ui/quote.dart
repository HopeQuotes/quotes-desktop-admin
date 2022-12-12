import 'dart:ui';

import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class Quote {
  String id;
  QuoteState state;
  String author;
  String text;
  List<String> hashtags;

  Quote(this.id, this.state, this.author, this.text, this.hashtags);
}

class QuoteState {
  String id;
  String value;
  bool idDefault;
  String color;

  QuoteState({
    required this.id,
    required this.value,
    required this.idDefault,
    required this.color,
  });
}
