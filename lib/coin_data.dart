import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String coinAPI = 'https://rest.coinapi.io/v1/exchangerate';
const String APIKey = '0A8B8D9E-2D06-417C-B718-5CC5FCC1A017';

class CoinData {
  Future<int> getCoinData(String sourceCurrency, String targetCurrency) async {
    String url = '$coinAPI/$sourceCurrency/$targetCurrency?apikey=$APIKey';
    http.Response coinData = await http.get(url);

    if (coinData.statusCode == 200) {
      var data = jsonDecode(coinData.body);
      int rate = data['rate'].toInt();
      return rate;
    }

    return 5;
  }
}
