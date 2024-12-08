import 'package:http/http.dart' as http;
import 'dart:convert'; // For converting the JSON response to Dart objects

class NetworkService {
  final String baseUrl = 'https://dev.itinstruct.com/fetch_irshadate.php'; // Your API endpoint

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/your-endpoint'));

      if (response.statusCode == 200) {
        // Parse the JSON data from the response
        List<dynamic> jsonData = json.decode(response.body);
        // Convert to a list of maps
        return jsonData.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
