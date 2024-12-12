import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../accessibility/accessibility_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  List<String> switchEvents = [];
  int warningCount = 0;
  bool isBlocked = false;

  // Aadhar verification states
  final _aadharController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;
  bool _aadharVerified = false;

  // Exam states (existing code)
  String selectedSkill = 'Select Skill';
  bool examStarted = false;
  bool examSubmitted = false;
  int currentQuestion = 0;
  List<int?> answers = List.filled(5, null);
  Timer? timer;
  int secondsRemaining = 1800; // 30 minutes

  final List<String> skills = [
    'Select Skill',
    'Filmmaking',
    'Programming',
    'Management'
  ];

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the primary role of a film director?',
      'options': [
        'Managing budget',
        'Creative vision and storytelling',
        'Camera operation',
        'Script writing'
      ],
      'correct': 1,
    },
    {
      'question': 'Which programming language is known for web development?',
      'options': ['JavaScript', 'Swift', 'Kotlin', 'C++'],
      'correct': 0,
    },
    {
      'question': 'What is a key principle of Agile project management?',
      'options': [
        'Rigid planning',
        'Minimal communication',
        'Iterative development',
        'Fixed scope'
      ],
      'correct': 2,
    },
    {
      'question': 'In filmmaking, what is a "dolly shot"?',
      'options': [
        'Camera mounted on wheels',
        'Aerial shot',
        'Handheld shot',
        'Static shot'
      ],
      'correct': 0,
    },
    {
      'question': 'What does OOP stand for in programming?',
      'options': [
        'Order of Operations',
        'Object Oriented Programming',
        'Online Operating Platform',
        'Output Optimization Process'
      ],
      'correct': 1,
    },
  ];

  Future<void> _sendOTP() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://20.197.18.36:8000/api/send-otp'),
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
        Uri.parse('http://20.197.18.36:8000/api/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'aadharNo': _aadharController.text,
          'otp': _otpController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _userData = data['userData'];
          _aadharVerified = true;
        });
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

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          submitExam();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startExam() {
    setState(() {
      examStarted = true;
    });
    startTimer();
  }

  void submitExam() {
    // Cancel the timer if it's running
    timer?.cancel();

    // Calculate results
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i]['correct']) {
        correctAnswers++;
      }
    }

    // Update state to show results
    setState(() {
      examSubmitted = true;
    });

    // Show submission confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exam submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Send results via SMS
    _sendResultsSMS();
  }

  Future<void> _sendResultsSMS() async {
    if (_userData == null) return;

    // Calculate results
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i]['correct']) {
        correctAnswers++;
      }
    }
    final double percentage = (correctAnswers / questions.length) * 100;
    final String grade = percentage >= 80
        ? 'A'
        : percentage >= 60
            ? 'B'
            : percentage >= 40
                ? 'C'
                : 'F';

    // Construct the SMS message
    String message = '''
Assessment Results for ${_userData!['date']['name']}:
Skill: $selectedSkill
Score: $correctAnswers/${questions.length} (${percentage.toStringAsFixed(1)}%)
Grade: $grade

Question Details:
''';

    // Add each question and its result
    for (int i = 0; i < questions.length; i++) {
      final bool isCorrect = answers[i] == questions[i]['correct'];
      message += '''
Q${i + 1}: ${questions[i]['question']}
Your Answer: ${questions[i]['options'][answers[i] ?? 0]}
Correct Answer: ${questions[i]['options'][questions[i]['correct']]}
${isCorrect ? '✓ Correct' : '✗ Incorrect'}

''';
    }

    try {
      final response = await http.post(
        Uri.parse('http://20.197.18.36:8000/api/send-sms'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phoneNo': _userData!['Phone no'],
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Results sent to your phone'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw json.decode(response.body)['error'];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send results: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showQuestionNavigator() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Go to Question'),
        content: Container(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              bool isAnswered = answers[index] != null;
              return InkWell(
                onTap: () {
                  setState(() => currentQuestion = index);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentQuestion == index
                        ? Theme.of(context).primaryColor
                        : isAnswered
                            ? Colors.green
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: currentQuestion == index || isAnswered
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show Aadhar verification first
    if (!_aadharVerified) {
      return _buildAadharVerification();
    }

    // Then follow the exam flow
    if (!examStarted) {
      return _buildSkillSelection();
    } else if (examStarted && !examSubmitted) {
      return FGBGNotifier(
        onEvent: (event) {
          print('App State Changed: $event'); // Debug print
          if (event == FGBGType.background) {
            _handleScreenSwitch();
          }
        },
        child: _buildExamContent(),
      );
    } else {
      return _buildResultsWithUserInfo();
    }
  }

  void _handleScreenSwitch() {
    setState(() {
      warningCount++;
      switchEvents.add('${DateTime.now()}: Screen switch detected');
    });

    if (warningCount <= 2) {
      // Show warning
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Warning ${warningCount}/2: Switching screens is not allowed! '
            'Next violation will block you.',
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      // Block user
      _blockUser();
    }
  }

  void _blockUser() {
    timer?.cancel(); // Stop the exam timer
    setState(() {
      isBlocked = true;
      examSubmitted = true;
    });

    _sendBlockedNotification();
  }

  Future<void> _sendBlockedNotification() async {
    if (_userData == null) return;

    final message = '''
🚫 EXAM BLOCKED - VIOLATION NOTICE 🚫

Candidate: ${_userData!['date']['name']}
Skill Assessment: $selectedSkill

Your exam has been terminated and your account has been blocked due to multiple violations.

Violations detected:
${switchEvents.join('\n')}

This incident has been reported to the administrator.
Please contact support for further assistance.
''';

    try {
      final response = await http.post(
        Uri.parse('http://20.197.18.36:8000/api/send-sms'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phoneNo': _userData!['Phone no'],
          'message': message,
        }),
      );

      if (response.statusCode != 200) {
        throw json.decode(response.body)['error'];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAadharVerification() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Identity'),
        backgroundColor: const Color(0xFF1B7BAB),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
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
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : Icon(Icons.send),
                        label: Text('Send OTP'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Color(0xFF1B7BAB),
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
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : Icon(Icons.verified_user),
                        label: Text('Verify OTP'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Color(0xFF1B7BAB),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSelection() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Assessment'),
        backgroundColor: const Color(0xFF1B7BAB),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Your Skill',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedSkill,
                  isExpanded: true,
                  items: skills.map((String skill) {
                    return DropdownMenuItem<String>(
                      value: skill,
                      child: Text(skill),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSkill = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectedSkill != 'Select Skill' ? startExam : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7BAB),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Start Assessment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamContent() {
    if (isBlocked) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(height: 24),
                Text(
                  'ACCOUNT BLOCKED',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your account has been blocked due to multiple violations.\n\n'
                  'Switching screens during the exam is strictly prohibited.\n\n'
                  'This incident has been reported.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 24),
                // Show violation history
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Violation History:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...switchEvents.map((event) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.warning,
                                    size: 16, color: Colors.orange),
                                SizedBox(width: 8),
                                Expanded(child: Text(event)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: Text(
                    'Exit Exam',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Return your existing exam UI here
    return _buildExam(); // This should be your existing exam UI method
  }

  Widget _buildExam() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFF1B7BAB),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.school, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '$selectedSkill test',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.timer, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text(
                              formatTime(secondsRemaining),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.accessibility_new, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccessibilityScreen(),
                            ),
                          );
                        },
                        tooltip: 'Accessibility Settings',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: answers.where((a) => a != null).length /
                        questions.length,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),

            // Question Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: QuestionCard(
                  questionNumber: currentQuestion + 1,
                  totalQuestions: questions.length,
                  question: questions[currentQuestion]['question'],
                  options: questions[currentQuestion]['options'],
                  selectedAnswer: answers[currentQuestion],
                  onAnswerSelected: (value) {
                    setState(() {
                      answers[currentQuestion] = value;
                    });
                  },
                ),
              ),
            ),

            // Question Navigation
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: currentQuestion > 0
                            ? () => setState(() => currentQuestion--)
                            : null,
                        icon: Icon(Icons.chevron_left),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = -1; i <= 1; i++)
                            if (currentQuestion + i >= 0 &&
                                currentQuestion + i < questions.length)
                              GestureDetector(
                                onTap: () => setState(() =>
                                    currentQuestion = currentQuestion + i),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: i == 0 ? Color(0xFF1B7BAB) : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${currentQuestion + i + 1}',
                                    style: TextStyle(
                                      fontSize: i == 0 ? 20 : 16,
                                      fontWeight: i == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: i == 0
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                      IconButton(
                        onPressed: currentQuestion < questions.length - 1
                            ? () => setState(() => currentQuestion++)
                            : null,
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: showQuestionNavigator,
                    child: Text('View all questions'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            answers.every((answer) => answer != null) ? submitExam : null,
        label: Text('Submit Exam'),
        icon: Icon(Icons.send),
        backgroundColor: answers.every((answer) => answer != null)
            ? Colors.green
            : Colors.grey,
      ),
    );
  }

  Widget _buildResultsWithUserInfo() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i]['correct']) {
        correctAnswers++;
      }
    }

    final double percentage = (correctAnswers / questions.length) * 100;
    final String grade = percentage >= 80
        ? 'A'
        : percentage >= 60
            ? 'B'
            : percentage >= 40
                ? 'C'
                : 'F';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Results'),
        backgroundColor: const Color(0xFF1B7BAB),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            if (_userData != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Candidate Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      _buildInfoRow('Name', _userData!['date']['name']),
                      _buildInfoRow('Phone', _userData!['Phone no']),
                      if (_userData!['disability'] != false) ...[
                        SizedBox(height: 8),
                        _buildInfoRow('Disability Type',
                            _userData!['disability']['disability type']),
                        _buildInfoRow('Disability %',
                            '${_userData!['disability']['percentage of disability']}%'),
                      ],
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Results Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assessment Results',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grade:'),
                        Text(
                          grade,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: grade == 'A'
                                ? Colors.green
                                : grade == 'F'
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Score:'),
                        Text(
                            '$correctAnswers/${questions.length} (${percentage.toStringAsFixed(1)}%)'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Add Violation History Card if there are any violations
            if (switchEvents.isNotEmpty) ...[
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Screen Switch Violations',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: switchEvents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    switchEvents[index],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (isBlocked) ...[
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.block, color: Colors.red),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Account was blocked due to multiple violations',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final int totalQuestions;
  final String question;
  final List<dynamic> options;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;

  const QuestionCard({
    required this.questionNumber,
    required this.totalQuestions,
    required this.question,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question $questionNumber/$totalQuestions',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            ...List.generate(
              options.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => onAnswerSelected(index),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedAnswer == index
                          ? Color(0xFF1B7BAB).withOpacity(0.1)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedAnswer == index
                            ? Color(0xFF1B7BAB)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedAnswer == index
                                  ? Color(0xFF1B7BAB)
                                  : Colors.grey[400]!,
                            ),
                          ),
                          child: selectedAnswer == index
                              ? Center(
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF1B7BAB),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedAnswer == index
                                  ? Color(0xFF1B7BAB)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
