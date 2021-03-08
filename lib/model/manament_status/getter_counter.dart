import 'package:flutter/material.dart' show required;

class GetterCounter {
  GetterCounter({
    @required this.increment,
    @required this.refresh,
  }) {
    _count = increment;
  }
  final int increment;
  final Function refresh;
  int _count = 0;

  int get value => _count;

  reload() {
    _count = increment;
    refresh();
  }

  more() {
    _count += increment;
    refresh();
  }
}
