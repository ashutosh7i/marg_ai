import 'package:margai_flutter/imports.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

/// Represents the assessment screen where students can view and take exams
class TakeAssessmentScreen2 extends StatefulWidget {
  const TakeAssessmentScreen2({super.key});

  @override
  State<TakeAssessmentScreen2> createState() => _TakeAssessmentScreen2State();
}

class Question {
  final String type;
  final String question;
  final List<String>? options; // null for descriptive questions
  final String? correctAnswer;
  final String? gradingCriteria;

  Question({
    required this.type,
    required this.question,
    this.options,
    this.correctAnswer,
    this.gradingCriteria,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'] ?? 'descriptive',
      question: json['question'] ?? '',
      options: json['type'] == 'MCQ'
          ? List<String>.from(json['options'] ?? [])
          : null,
      correctAnswer: json['correct_answer'],
      gradingCriteria: json['grading_criteria'],
    );
  }
}

class _TakeAssessmentScreen2State extends State<TakeAssessmentScreen2> {
  bool isLoading = false;
  String? error;
  List<Question>? questions;
  Map<String, dynamic>? examDetails;
  String loadingMessage = 'Initializing...';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeExam();
  }

  /// Initializes the exam by generating questions
  Future<void> _initializeExam() async {
    await generateQuestions();
  }

  /// Generates questions using the AI API
  Future<void> generateQuestions() async {
    setState(() {
      isLoading = true;
      error = null;
      loadingMessage = 'Preparing assessment questions...';
    });

    try {
      // Sample form data - you can make this dynamic based on your needs
      final formData = {
        "subject": "Computer Science",
        "subtopics": [
          "Data Structures",
          "Algorithms",
          "Programming Fundamentals"
        ],
        "difficultyLevel": "7",
        "numberOfQuestions": "10",
        "language": "English",
        "targetAudience": "Undergraduate Students"
      };

      setState(() {
        loadingMessage = 'Formatting request...';
      });

      final formattedData = {
        "subject": formData["subject"],
        "subtopics": formData["subtopics"],
        "type": ["MCQ", "descriptive"],
        "difficulty level": "${formData["difficultyLevel"]} on 10",
        "number of questions": formData["numberOfQuestions"],
        "language": formData["language"],
        "target audience": formData["targetAudience"],
      };

      setState(() {
        loadingMessage = 'Generating questions using AI...';
      });

      // Make API request with timeout
      final response = await _makeApiRequest(formattedData)
          .timeout(Duration(minutes: 2), onTimeout: () {
        throw TimeoutException('Request is taking longer than expected');
      });

      setState(() {
        loadingMessage = 'Processing response...';
      });

      await _processApiResponse(response);
    } on TimeoutException catch (e) {
      _handleError('Request timed out. Please try again.');
    } catch (e) {
      _handleError(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Makes the API request to generate questions
  Future<http.Response> _makeApiRequest(
      Map<String, dynamic> formattedData) async {
    return await http.post(
      Uri.parse(
          "https://himmaannsshhuu-langflow.hf.space/api/v1/run/6739c578-ae8f-4475-962d-af0f0cf33f2d"),
      headers: {
        "Authorization": "Bearer <TOKEN>",
        "Content-Type": "application/json",
        "x-api-key": "<your api key>",
      },
      body: jsonEncode({
        "input_value": jsonEncode(formattedData),
        "output_type": "chat",
        "input_type": "chat",
        "tweaks": {
          "ChatInput-B0syb": {},
          "Prompt-1hx2Q": {},
          "ChatOutput-UYiOG": {},
          "OpenAIModel-bCclS": {},
          "Memory-fpa94": {},
        },
      }),
    );
  }

  /// Processes the API response and updates the state
  Future<void> _processApiResponse(http.Response response) async {
    try {
      final data = jsonDecode(response.body);
      final questionPaperText = data["outputs"][0]["outputs"][0]["results"]
          ["message"]["data"]["text"];
      final questionPaper = jsonDecode(questionPaperText);

      if (!questionPaper.containsKey("questions")) {
        throw FormatException('Response does not contain questions');
      }

      final questionsList = questionPaper["questions"] as List;
      final parsedQuestions = questionsList
          .map((q) => Question.fromJson({
                'type': q['type'],
                'question': q['question prompt'],
                'options':
                    q['type'] == 'MCQ' ? List<String>.from(q['options']) : null,
                'correct_answer':
                    q['type'] == 'MCQ' ? q['correct answer'] : null,
                'grading_criteria':
                    q['type'] == 'descriptive' ? q['grading criteria'] : null,
              }))
          .toList();

      setState(() {
        questions = parsedQuestions;
        examDetails = {
          "title": questionPaper["subject"],
          "description":
              "Assessment covering ${(questionPaper["subtopics"] as List).join(", ")}",
          "deadline": DateTime.now().add(Duration(days: 7)),
          "duration": 45,
          "totalMarks": questions?.length ?? 0,
          "passingMarks": (questions?.length ?? 0) * 0.4,
          "instructions": [
            "Read each question carefully before answering",
            "You cannot return to previous questions once submitted",
            "Ensure stable internet connection throughout the exam",
            "Do not refresh the page during the exam",
            "Timer will automatically submit the exam when time is up"
          ]
        };
      });
    } catch (e) {
      print('Response parsing error: $e');
      throw Exception('Failed to parse questions: $e');
    }
  }

  /// Handles any errors that occur during question generation
  void _handleError(dynamic error) {
    setState(() {
      this.error = "Failed to generate questions: $error";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: ${error.toString()}"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Assessment'),
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              loadingMessage,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'This may take a few minutes...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            // Show retry button if it's taking too long
            if (loadingMessage.contains('AI')) ...[
              SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  generateQuestions();
                },
                child: Text('Retry Generation'),
              ),
            ],
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[700]),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                generateQuestions();
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Take Assessment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            if (examDetails != null) _buildExamDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildExamDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExamHeader(),
          _buildDeadlineSection(),
          _buildDescriptionSection(),
          _buildExamStats(),
          _buildInstructions(),
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildExamHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          examDetails!["title"],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDeadlineSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: Colors.red),
          SizedBox(width: 8),
          Text(
            'Deadline: ${DateFormat('MMMM dd, yyyy h:mm a').format(examDetails!["deadline"])}',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            examDetails!["description"],
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildExamStats() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
              Icons.timer, 'Duration', '${examDetails!["duration"]} min'),
          _buildStatItem(Icons.quiz, 'Questions', '${questions?.length ?? 0}'),
          _buildStatItem(
              Icons.stars, 'Total Marks', '${examDetails!["totalMarks"]}'),
          _buildStatItem(
              Icons.check_circle, 'Passing', '${examDetails!["passingMarks"]}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 20),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instructions:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...examDetails!["instructions"].map((instruction) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right, size: 20, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        instruction,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (questions != null) {
            _showStartExamDialog();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0288D1),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow),
            SizedBox(width: 8),
            Text(
              'Start Assessment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showStartExamDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start Exam'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you ready to start the exam?'),
            SizedBox(height: 16),
            Text(
              'Note: Timer will start immediately and cannot be paused.',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExamScreen(
                    questions: questions!,
                    examDetails: examDetails!,
                  ),
                ),
              );
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}

/// Screen where students take the actual exam
class ExamScreen extends StatefulWidget {
  final List<Question> questions;
  final Map<String, dynamic> examDetails;

  const ExamScreen({
    required this.questions,
    required this.examDetails,
    super.key,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentQuestionIndex = 0;
  Map<int, String> answers = {};
  Timer? timer;
  int remainingSeconds = 0;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.examDetails["duration"] * 60;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
          if (remainingSeconds <= 300) {
            // 5 minutes remaining
            _showTimeWarning();
          }
        } else {
          submitExam(isAutoSubmit: true);
        }
      });
    });
  }

  void _showTimeWarning() {
    if (remainingSeconds == 300) {
      // Show warning at exactly 5 minutes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ 5 minutes remaining!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> submitExam({bool isAutoSubmit = false}) async {
    if (isSubmitting) return;

    setState(() {
      isSubmitting = true;
    });

    timer?.cancel();

    if (isAutoSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Time\'s up! Exam submitted automatically.'),
          backgroundColor: Colors.orange,
        ),
      );
    }

    try {
      // Here you would send the answers to your backend
      await Future.delayed(Duration(seconds: 2)); // Simulated API call

      Navigator.pop(context);
      _showSubmissionSuccessDialog();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit exam: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void _showSubmissionSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Exam Submitted'),
        content: Text('Your exam has been submitted successfully.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to results page or dashboard
            },
            child: Text('OK'),
          ),
        ],
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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitConfirmationDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildExamBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
          'Question ${currentQuestionIndex + 1}/${widget.questions.length}'),
      actions: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: remainingSeconds <= 300
                  ? Colors.red.shade100
                  : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: remainingSeconds <= 300 ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildExamBody() {
    final question = widget.questions[currentQuestionIndex];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionCard(question),
          SizedBox(height: 24),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: question.type == "MCQ"
                        ? Colors.blue.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question.type,
                    style: TextStyle(
                      color: question.type == "MCQ"
                          ? Colors.blue.shade900
                          : Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              question.question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildAnswerSection(question),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(Question question) {
    if (question.type == "MCQ" && question.options != null) {
      return Column(
        children: question.options!
            .map<Widget>((option) => Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: RadioListTile<String>(
                    value: option,
                    groupValue: answers[currentQuestionIndex],
                    onChanged: (value) {
                      setState(() {
                        answers[currentQuestionIndex] = value ?? '';
                      });
                    },
                    title: Text(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ))
            .toList(),
      );
    } else {
      return TextField(
        maxLines: 8,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Enter your answer here...',
          fillColor: Colors.grey.shade50,
          filled: true,
        ),
        onChanged: (value) {
          answers[currentQuestionIndex] = value;
        },
        controller: TextEditingController(text: answers[currentQuestionIndex]),
      );
    }
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentQuestionIndex > 0)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                currentQuestionIndex--;
              });
            },
            icon: Icon(Icons.arrow_back),
            label: Text('Previous'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black,
            ),
          ),
        if (currentQuestionIndex < widget.questions.length - 1)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                currentQuestionIndex++;
              });
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Next'),
          ),
        if (currentQuestionIndex == widget.questions.length - 1)
          ElevatedButton.icon(
            onPressed:
                isSubmitting ? null : () => _showSubmitConfirmationDialog(),
            icon: Icon(Icons.check),
            label: Text(isSubmitting ? 'Submitting...' : 'Submit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
      ],
    );
  }

  Future<bool?> _showExitConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit Exam?'),
        content:
            Text('Are you sure you want to exit? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Exit'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  void _showSubmitConfirmationDialog() {
    final unansweredCount = widget.questions.length - answers.length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Submit Exam?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to submit your exam?'),
            if (unansweredCount > 0) ...[
              SizedBox(height: 16),
              Text(
                '⚠️ You have $unansweredCount unanswered questions.',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              submitExam();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

/// Add this class for results
class ExamResult {
  final int totalQuestions;
  final int correctAnswers;
  final double percentage;
  final String grade;
  final List<QuestionResult> questionResults;

  ExamResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.percentage,
    required this.grade,
    required this.questionResults,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      totalQuestions: json['total_questions'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      percentage: json['percentage']?.toDouble() ?? 0.0,
      grade: json['grade'] ?? 'N/A',
      questionResults: (json['question_results'] as List?)
          ?.map((q) => QuestionResult.fromJson(q))
          .toList() ?? [],
    );
  }
}

class QuestionResult {
  final String question;
  final String userAnswer;
  final String? correctAnswer;
  final bool isCorrect;
  final String? feedback;

  QuestionResult({
    required this.question,
    required this.userAnswer,
    this.correctAnswer,
    required this.isCorrect,
    this.feedback,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      question: json['question'] ?? '',
      userAnswer: json['user_answer'] ?? '',
      correctAnswer: json['correct_answer'],
      isCorrect: json['is_correct'] ?? false,
      feedback: json['feedback'],
    );
  }
}
