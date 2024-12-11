import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../models/user.dart';

class AuthService {
  // static const String baseUrl = 'http://localhost:5000/api';

  static const String baseUrl = 'http://20.197.18.36:5000/api';
  static const String tokenKey = 'auth_token';
  static const String languageKey = 'temp_language';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<String?> get token async {
    print('Fetching token from shared preferences...');
    final token = _prefs.getString(tokenKey);
    print('Token fetched: $token');
    return token;
  }

  // Get temporary language preference
  String getTemporaryLanguage() {
    print('Retrieving temporary language preference...');
    final language = _prefs.getString(languageKey) ?? 'en';
    print('Temporary language preference is: $language');
    return language;
  }

  // Set temporary language preference
  Future<void> setTemporaryLanguage(String languageCode) async {
    print('Setting temporary language preference to: $languageCode');
    await _prefs.setString(languageKey, languageCode);
    print('Temporary language preference set successfully.');
  }

  Future<bool> isLoggedIn() async {
    print('Checking if user is logged in...');
    final loggedIn = await token != null;
    print('User logged in status: $loggedIn');
    return loggedIn;
  }

  Future<Map<String, dynamic>> signup(
      String username, String email, String password,
      {String? language}) async {
    print('Signing up user with username: $username, email: $email');
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'preferredLanguage': language ?? getTemporaryLanguage(),
      }),
    );

    if (response.statusCode == 201) {
      print('Signup successful, processing response...');
      final data = jsonDecode(response.body);
      print(data);
      await _prefs.setString(tokenKey, data['token']);
      print('Token saved after signup: ${data['token']}');
      return data;
    } else {
      print('Signup failed with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    print('Logging in user with email: $email');
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Login successful, processing response...');
      final data = jsonDecode(response.body);
      await _prefs.setString(tokenKey, data['token']);
      print('Token saved after login: ${data['token']}');
      return data;
    } else {
      print('Login failed with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    print('Requesting password reset for email: $email');
    final response = await http.post(
      Uri.parse('$baseUrl/auth/request-reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      print(
          'Password reset request failed with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
    print('Password reset request sent successfully.');
  }

  Future<void> resetPassword(String resetToken, String newPassword) async {
    print('Resetting password with token: $resetToken');
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'resetToken': resetToken,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      print('Password reset failed with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
    print('Password reset successfully.');
  }

  Future<Map<String, dynamic>> getProfile() async {
    print('Fetching user profile...');
    final token = await this.token;
    if (token == null) {
      print('Not authenticated, cannot fetch profile.');
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Profile fetched successfully, processing response...');
      final data = jsonDecode(response.body);
      // Map 'class' to 'studentClass' for frontend
      if (data['class'] != null) {
        data['studentClass'] = data['class'];
      }
      return data;
    } else {
      print('Failed to fetch profile with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? username,
    String? name,
    String? bio,
    String? studentClass,
    String? language,
  }) async {
    print('Updating user profile...');
    final token = await this.token;
    if (token == null) {
      print('Not authenticated, cannot update profile.');
      throw Exception('Not authenticated');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        if (username != null) 'username': username,
        if (name != null) 'name': name,
        if (bio != null) 'bio': bio,
        if (studentClass != null) 'class': studentClass, // Use 'class' for API
        if (language != null) 'preferredLanguage': language,
      }),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully, processing response...');
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to update profile with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<String> uploadProfilePicture(XFile imageFile) async {
    print('Uploading profile picture for user...');
    final token = await this.token;
    if (token == null) {
      print('Not authenticated, cannot upload profile picture.');
      throw Exception('Not authenticated');
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/profile/picture'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    // Read the file as bytes
    final bytes = await imageFile.readAsBytes();
    print('Read ${bytes.length} bytes from image file.');

    // Create multipart file from bytes
    final multipartFile = http.MultipartFile.fromBytes(
      'profilePicture',
      bytes,
      filename: imageFile.name,
      contentType: MediaType('image', imageFile.name.split('.').last),
    );

    request.files.add(multipartFile);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Profile picture uploaded successfully, processing response...');
      final data = jsonDecode(response.body);
      return data['profilePictureUrl'];
    } else {
      print(
          'Failed to upload profile picture with status code: ${response.statusCode}');
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> logout() async {
    print('Logging out user...');
    await _prefs.remove(tokenKey);
    print('User logged out successfully.');
  }
}
