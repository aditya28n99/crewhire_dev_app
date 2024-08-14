import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employer_model.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<Employer> fetchEmployerProfile(String employerId) async {
    final url =
        Uri.parse('http://13.201.62.223:8000/employerProfile/get/$employerId');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        return Employer.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load employer profile');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<void> createEmployerProfile(Employer employer) async {
    final url = Uri.parse('http://13.201.62.223:8000/employerProfile/create');

    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(employer.toJson()), // Convert Employer to JSON
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create employer profile');
      }
    } catch (error) {
      throw Exception('Profile creation error: $error');
    }
  }

  static Future<void> updateEmployerProfile(
      String employerId, Employer employer) async {
    final url = Uri.parse(
        'http://13.201.62.223:8000/employerProfile/updateEmployerProfile/$employerId');

    try {
      var response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(employer.toJson()),
        // body: jsonEncode({
        //   'aboutCompany': employer.aboutCompany
        // }), // Convert Employer to JSON
      );
      print(employer.toJson());
      print('Request Body: ${jsonEncode(employer.toJson())}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Body: ${employer.aboutCompany}');
      print('Response Body: ${jsonEncode({
            'aboutCompany': employer.aboutCompany
          })}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update employer profile');
      }
    } catch (error) {
      throw Exception('Profile update error: $error');
    }
  }
}
