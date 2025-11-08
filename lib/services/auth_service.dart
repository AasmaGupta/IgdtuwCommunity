import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AuthService {
  static String get baseUrl {
    // Use 10.0.2.2 for Android emulator, localhost for iOS simulator and web, and IP for physical devices
    if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
      return 'http://10.0.2.2:3000/api/auth';
    } else if ((defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb) ||
        kIsWeb) {
      return 'http://localhost:3000/api/auth';
    }
    return 'http://192.168.0.196:3000/api/auth';
  }

  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Attempting to connect to: ${baseUrl}/login'); // Debug print
      final response = await _client
          .post(
            Uri.parse('${baseUrl}/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } on SocketException catch (e) {
      print('Socket Exception: ${e.message}'); // Debug print
      throw Exception(
          'Network error: Please check your internet connection and try again. Error: ${e.message}');
    } catch (e) {
      print('General Exception: $e'); // Debug print
      throw Exception('Failed to login: $e');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await _client
          .post(
            Uri.parse('${baseUrl}/register'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } on SocketException catch (e) {
      throw Exception(
          'Network error: Please check your internet connection and try again. Error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
