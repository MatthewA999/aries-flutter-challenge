class OptionContract {
  String type;
  double strikePrice;
  double bid;
  double ask;
  String longShort;
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
      type: json['type'],
      strikePrice: json['strike_price'].toDouble(),
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      longShort: json['long_short'],
    );
  }
}
