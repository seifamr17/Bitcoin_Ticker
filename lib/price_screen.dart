import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'currency_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String targetCurrency = 'USD';
  CoinData coinData = CoinData();
//  int exchangeRateBTC;
//  int exchangeRateETH;
//  int exchangeRateLTC;
  List<int> exchangeRates = [null, null, null];

  void updateUI() async {
    exchangeRates[0] = await coinData.getCoinData('btc', targetCurrency);
    exchangeRates[1] = await coinData.getCoinData('eth', targetCurrency);
    exchangeRates[2] = await coinData.getCoinData('ltc', targetCurrency);
    setState(() {});
  }

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton(
      value: targetCurrency,
      items: dropDownItems,
      onChanged: (value) {
        targetCurrency = value;
        updateUI();
      },
    );
  }

  Widget iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        targetCurrency = currenciesList[selectedIndex];
        updateUI();
      },
      children: pickerItems,
    );
  }

  List<Widget> buildCards() {
    List<Widget> cards = [];
    for (int i = 0; i < cryptoList.length; i++) {
      cards.add(
        CurrencyCard(
          exchangeRate: exchangeRates[i],
          sourceCurrency: cryptoList[i],
          targetCurrency: targetCurrency,
        ),
      );
    }
    return cards;
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildCards(),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidDropDown()),
        ],
      ),
    );
  }
}
