import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/options_contract.dart';
import 'package:flutter_challenge/options_calculator/options_calculator.dart';
import 'package:flutter_challenge/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Options Profit Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OptionsCalculator(
        optionsData: OPTIONS_DATA.map(OptionContract.fromJson).toList(),
      ),
    );
  }
}
