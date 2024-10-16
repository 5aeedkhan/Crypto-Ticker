import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:btc/Utilities/url.dart';

class CryptoService {
  Future<double> getCryptoPrice(String symbol, String selectedCurrency) async {
    final response = await http.get(Uri.parse(
        "$baseUrl?${apiKey}&amount=1&symbol=$symbol&convert=$selectedCurrency"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['data']['quote'][selectedCurrency]['price'];
    } else {
      throw Exception('Error fetching data: ${response.statusCode}');
    }
  }
}
