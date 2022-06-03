import 'dart:convert';


import 'package:http/http.dart' as http;

class API {
  static bool isLoading = true;
 static String message = '';
  static Future<List<dynamic>> getRequest() async {
    try {
      String url =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false';
      http.Response response = await http.get(
        Uri.parse(url),
      );

      var decodedData = jsonDecode(response.body);
      List<dynamic> markets = decodedData as List<dynamic>;
      return markets;
    }
    catch (e) {
      //print(e);
      return [];
    }
  }
}
