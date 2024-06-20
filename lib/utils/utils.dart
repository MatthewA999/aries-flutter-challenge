import 'dart:math';

import 'package:flutter_challenge/models/options_contract.dart';
import 'package:flutter_challenge/utils/enums.dart';

double calculatePayOffAtPrice(
    double price, List<OptionContract> selectedOptions) {
  return selectedOptions.fold<double>(0.0, (acc, option) {
    double cost = (option.bid + option.ask) / 2;

    if (option.type == CallType.call) {
      if (option.longShort == CallOption.long) {
        return acc + max(0, price - option.strikePrice) - cost;
      } else {
        return acc + cost - max(0, price - option.strikePrice);
      }
    } else if (option.type == CallType.put) {
      if (option.longShort == CallOption.long) {
        return acc + max(0, option.strikePrice - price) - cost;
      } else {
        return acc + cost - max(0, option.strikePrice - price);
      }
    }
    return acc;
  });
}

/// Finds the x-axis intersection point given two points (x1, y1) and (x2, y2).
///
/// This function calculates the x-coordinate where a line passing through the points
/// (x1, y1) and (x2, y2) intersects the x-axis (i.e., where y = 0).
///
/// The equation of the line passing through (x1, y1) and (x2, y2) is:
/// y - y1 = m * (x - x1)
/// where m is the slope of the line.
///
/// Solving for x when y = 0 gives:
/// x = -c / m
/// where c = y1 - m * x1 is the y-intercept of the line.
///
/// - Parameters:
///   - x1: The x-coordinate of the first point.
///   - y1: The y-coordinate of the first point.
///   - x2: The x-coordinate of the second point.
///   - y2: The y-coordinate of the second point.
///
/// - Returns: A [double] representing the x-coordinate where the line passing through
///            (x1, y1) and (x2, y2) intersects the x-axis.
double findXAxisIntersection(double x1, double y1, double x2, double y2) {
  final m = (y2 - y1) / (x2 - x1);
  final c = y1 - m * x1;
  return -c / m;
}
