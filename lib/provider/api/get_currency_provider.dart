import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  Future<double> getCryptoCurrency(String cryptoName) async {
    try {
      final url =
          Uri.parse('https://api.coingecko.com/api/v3/coins/$cryptoName');
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      final String value =
          json['market_data']['current_price']['usd'].toString();
      print(value);
      return double.parse(value);
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
