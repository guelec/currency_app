import 'package:flutter/foundation.dart';

/*
class USD {
  final Currency usd = Currency();

  USD({
    @required this.usd,
  });

  factory USD.fromJson(Map<String, dynamic> json) {
    return USD(
      usd: json['USD'],
    );
  }
}

class Currency {
  final String name;
  final double buy;
  final double sell;
  final String type;

  Currency({this.name, this.buy, this.sell, this.type});
}
*/

/*
class CurrencyList {
  final List<Currency> list;

  CurrencyList({this.list});

  factory CurrencyList.fromJson(List<dynamic> parsedJson) {
    List<Currency> list = new List<Currency>();
    list = parsedJson.map((i) => Currency.fromJson(i)).toList();
    return new CurrencyList(list: list);
  }
}

class Currency {
  final String name;
  final double buy;
  final double sell;
  final String type;

  Currency(
      {@required this.name,
      @required this.buy,
      @required this.sell,
      @required this.type});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        name: json['Buying'],
        buy: json['Selling'] as double,
        sell: json['Name'] as double,
        type: json['Type']);
  }
}
*/
