import 'dart:math';

import 'package:flutter_challenge/models/options_contract.dart';

double calculatePayOffAtPrice(
    double price, List<OptionContract> selectedOptions) {
  return selectedOptions.fold<double>(0.0, (acc, option) {
    double cost = (option.bid + option.ask) / 2;

    if (option.type == 'Call') {
      if (option.longShort == 'long') {
        return acc + max(0, price - option.strikePrice) - cost;
      } else {
        return acc + cost - max(0, price - option.strikePrice);
      }
    } else if (option.type == 'Put') {
      if (option.longShort == 'long') {
        return acc + max(0, option.strikePrice - price) - cost;
      } else {
        return acc + cost - max(0, option.strikePrice - price);
      }
    }
    return acc;
  });
}

double findXAxisIntersection(double x1, double y1, double x2, double y2) {
  final m = (y2 - y1) / (x2 - x1);
  final c = y1 - m * x1;
  return -c / m;
}
