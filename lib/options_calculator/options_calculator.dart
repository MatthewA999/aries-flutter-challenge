import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/options_contract.dart';
import 'package:flutter_challenge/utils/constants.dart';
import 'package:flutter_challenge/utils/utils.dart';

class OptionsCalculator extends StatefulWidget {
  final List<OptionContract> optionsData;

  const OptionsCalculator({super.key, required this.optionsData});

  @override
  _OptionsCalculatorState createState() => _OptionsCalculatorState();
}

class _OptionsCalculatorState extends State<OptionsCalculator> {
  List<double> prices = [];
  List<double> profits = [];
  double? maxProfit;
  double? maxLoss;
  List<double> breakEvenPoints = [];
  final String canvasId = 'pl-graph-${Random().nextInt(10000)}';

  @override
  void initState() {
    super.initState();
    calculatePayOff();
  }

  void calculatePayOff() {
    final selectedOptions =
        widget.optionsData.where((item) => item.isSelected ?? false).toList();

    if (selectedOptions.isEmpty) {
      setState(() {});
      return;
    }

    const minPrice = 0.0;
    final maxPrice =
        selectedOptions.map((opt) => opt.strikePrice).reduce(max) * 1.5;
    final tempPrices = [minPrice, maxPrice];
    final tempProfits = <double>[];

    for (final option in selectedOptions) {
      tempPrices.add(option.strikePrice);
      if (option.type == 'Call') {
        tempPrices.add(option.strikePrice + (option.bid + option.ask) / 2);
      } else {
        tempPrices.add(option.strikePrice - (option.bid + option.ask) / 2);
      }
    }

    tempPrices.sort();

    for (final price in tempPrices) {
      tempProfits.add(calculatePayOffAtPrice(price, selectedOptions));
    }

    breakEvenPoints.clear();
    for (int i = 0; i < tempPrices.length - 1; i++) {
      if ((tempProfits[i] < -ZERO_THRESHOLD &&
              tempProfits[i + 1] > ZERO_THRESHOLD) ||
          (tempProfits[i] > ZERO_THRESHOLD &&
              tempProfits[i + 1] < -ZERO_THRESHOLD)) {
        final x = findXAxisIntersection(tempPrices[i], tempProfits[i],
            tempPrices[i + 1], tempProfits[i + 1]);
        tempPrices.insert(i + 1, x);
        tempProfits.insert(i + 1, 0.0);
        breakEvenPoints.add(x);
        i++;
      }
    }

    setState(() {
      prices = tempPrices;
      profits = tempProfits;
      maxProfit = profits.reduce(max);
      maxLoss = profits.reduce(min);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options Profit Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (maxProfit != null &&
                maxLoss != null &&
                breakEvenPoints.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Text('Max Profit: ${maxProfit!.toStringAsFixed(2)}'),
                    Text('Max Loss: ${maxLoss!.toStringAsFixed(2)}'),
                    Text('Break Even Points: ${breakEvenPoints.join(', ')}'),
                  ],
                ),
              ),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: prices
                          .asMap()
                          .map((i, price) =>
                              MapEntry(i, FlSpot(price, profits[i])))
                          .values
                          .toList(),
                      isCurved: false,
                      barWidth: 2,
                      color: Colors.redAccent,
                      belowBarData: BarAreaData(show: false),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            Wrap(
              children: widget.optionsData.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: item.isSelected ?? false,
                      onChanged: (value) {
                        item.isSelected = value!;
                        calculatePayOff();
                      },
                    ),
                    Text(
                        '${item.longShort} ${item.type} - ${item.strikePrice}'),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
