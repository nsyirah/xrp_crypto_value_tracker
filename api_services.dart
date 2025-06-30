import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://api.mypapit.net/crypto/XRPMYR.json';

  static Future<double?> fetchXRPValue() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("DECODED JSON: $data");
        if (data['last_trade'] != null) {
          return double.tryParse(data['last_trade'].toString());
        }
      }
    } catch (e) {
      print("Error fetching XRP value: $e");
    }
    return null;
  }
}