import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AadharLoginPage extends StatefulWidget {
  @override
  _AadharLoginPageState createState() => _AadharLoginPageState();
}

class _AadharLoginPageState extends State<AadharLoginPage> {
  final _aadharController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  Future<void> _sendOTP() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'aadharNo': _aadharController.text}),
      );

      if (response.statusCode == 200) {
        setState(() => _otpSent = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent successfully')),
        );
      } else {
        throw json.decode(response.body)['error'];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyOTP() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'aadharNo': _aadharController.text,
          'otp': _otpController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _userData = data['userData']);
      } else {
        throw json.decode(response.body)['error'];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildUserDataCard() {
    if (_userData == null) return SizedBox.shrink();

    final bool hasDisability = _userData!['disability'] != false;

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Divider(height: 32),
            _buildInfoRow('Name', _userData!['date']['name']),
            _buildInfoRow('Date of Birth', _userData!['date']['dob']),
            _buildInfoRow('Aadhar Number', _userData!['aadhar no']),
            _buildInfoRow('Phone Number', _userData!['Phone no']),
            if (hasDisability) ...[
              SizedBox(height: 16),
              Text(
                'Disability Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Divider(height: 24),
              _buildInfoRow('UUID', _userData!['disability']['uuid']),
              _buildInfoRow(
                  'Type', _userData!['disability']['disability type']),
              _buildInfoRow('Percentage',
                  '${_userData!['disability']['percentage of disability']}%'),
              _buildInfoRow(
                  'Issue Date', _userData!['disability']['date of issue']),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label + ':',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aadhar Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_userData == null) ...[
                SizedBox(height: 32),
                TextField(
                  controller: _aadharController,
                  decoration: InputDecoration(
                    labelText: 'Aadhar Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                if (!_otpSent)
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _sendOTP,
                    icon: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Icon(Icons.send),
                    label: Text('Send OTP'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                if (_otpSent) ...[
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _verifyOTP,
                    icon: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Icon(Icons.verified_user),
                    label: Text('Verify OTP'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ],
              if (_userData != null) _buildUserDataCard(),
            ],
          ),
        ),
      ),
    );
  }
}
