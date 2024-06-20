import 'package:flutter_challenge/utils/enums.dart';

class OptionContract {
  CallType type;
  double strikePrice;
  double bid;
  double ask;
  CallOption longShort;
  bool? isSelected = true;

  OptionContract({
    required this.type,
    required this.strikePrice,
    required this.bid,
    required this.ask,
    required this.longShort,
  });

  factory OptionContract.fromJson(Map<String, dynamic> json) {
    return OptionContract(
      type: json['type'] == 'Call' ? CallType.call : CallType.put,
      strikePrice: json['strike_price'].toDouble(),
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      longShort:
          json['long_short'] == 'long' ? CallOption.long : CallOption.short,
    );
  }
}
