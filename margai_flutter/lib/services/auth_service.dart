import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../models/user.dart';

class AuthService {
  static const String baseUrl =
      'http://12.12.12.132:5000/api'; //http://12.12.12.132:5000/
  static const String tokenKey = 'auth_token';
  static const String languageKey = 'temp_language';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<String?> get token async => _prefs.getString(tokenKey);

  // Get temporary language preference
  String getTemporaryLanguage() {
    return _prefs.getString(languageKey) ?? 'en';
  }

  // Set temporary language preference
  Future<void> setTemporaryLanguage(String languageCode) async {
    await _prefs.setString(languageKey, languageCode);
  }

  Future<bool> isLoggedIn() async {
    return await token != null;
  }

  Future<Map<String, dynamic>> signup(
      String username, String email, String password,
      {String? language}) async {
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
      final data = jsonDecode(response.body);
      await _prefs.setString(tokenKey, data['token']);
      return data;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _prefs.setString(tokenKey, data['token']);
      return data;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/request-reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> resetPassword(String resetToken, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'resetToken': resetToken,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final token = await this.token;
    if (token == null) throw Exception('Not authenticated');

    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Map 'class' to 'studentClass' for frontend
      if (data['class'] != null) {
        data['studentClass'] = data['class'];
      }
      return data;
    } else {
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
    final token = await this.token;
    if (token == null) throw Exception('Not authenticated');

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
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<String> uploadProfilePicture(XFile imageFile) async {
    final token = await this.token;
    if (token == null) throw Exception('Not authenticated');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/profile/picture'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    // Read the file as bytes
    final bytes = await imageFile.readAsBytes();

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
      final data = jsonDecode(response.body);
      return data['profilePictureUrl'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> logout() async {
    await _prefs.remove(tokenKey);
  }
}
