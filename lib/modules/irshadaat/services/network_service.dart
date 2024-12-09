import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  final String baseUrl =
      'https://dev.itinstruct.com/';

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      debugPrint(baseUrl);
      final response = await http.get(Uri.parse('${baseUrl}fetch_irshadate.php'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> addIrshadate(String content, String category) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}irshadat/insert_irshadate.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "content": content,
          "category": category,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          debugPrint("Data inserted successfully");
        } else {
          debugPrint("Failed to insert data: ${responseData['message']}");
        }
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
    }
  }
}
