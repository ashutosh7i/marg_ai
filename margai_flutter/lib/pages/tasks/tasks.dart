import 'package:margai_flutter/imports.dart';
import 'package:margai_flutter/pages/tasks/test.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    'Live Assessments',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  LiveAssessmentCard(
                    subject: 'English',
                    type: 'Descriptive',
                    deadline: 'August 27, 2024 3:00 pm',
                    onStart: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakeAssessmentScreen(),
                        ),
                      );
                    },
                  ),
                  LiveAssessmentCard(
                    subject: 'Physics',
                    type: 'Practical',
                    deadline: 'August 27, 2024 3:00 pm',
                    onStart: () {},
                  ),
                  LiveAssessmentCard(
                    subject: 'Computer Science',
                    type: 'MCQ',
                    deadline: 'August 27, 2024 3:00 pm',
                    onStart: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakeAssessmentScreen2(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Past Assessments',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  PastAssessmentCard(
                    subject: 'Hindi',
                    type: 'Viva Voice',
                    submittedDate: 'August 27, 2024 3:00 pm',
                    onView: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveAssessmentCard extends StatelessWidget {
  final String subject;
  final String type;
  final String deadline;
  final VoidCallback onStart;

  const LiveAssessmentCard({
    super.key,
    required this.subject,
    required this.type,
    required this.deadline,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Type: $type',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Deadline: $deadline',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

class PastAssessmentCard extends StatelessWidget {
  final String subject;
  final String type;
  final String submittedDate;
  final VoidCallback onView;

  const PastAssessmentCard({
    super.key,
    required this.subject,
    required this.type,
    required this.submittedDate,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Type: $type',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Submitted: $submittedDate',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onView,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}

class TakeAssessmentScreen extends StatelessWidget {
  const TakeAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title of the Assessment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Deadline: August 27, 2024 3:00 pm',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Students, you will be taking an assessment test titled "Sample Exam Test" as part of your assessment. The test will cover topics from the syllabus discussed so far.\n\nEnsure you are prepared and give the test on time. Good luck!',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type: Type of Assessment'),
                                  Text('Test Time: 30 minutes'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('No. of questions: 20'),
                                  Text('Total Marks: 20'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TestScreen(
                                        type: AssessmentType.descriptive),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0288D1),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Start Assessment',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////
///
// second code //bottom code
enum AssessmentType { mcq, descriptive }

class TestScreen extends StatefulWidget {
  final AssessmentType type;

  const TestScreen({
    super.key,
    required this.type,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentQuestion = 1;
  int totalQuestions = 20;
  Map<int, dynamic> answers = {};
  Timer? timer;
  int secondsRemaining = 1488; // 24:48 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          // Handle time up
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
            itemCount: totalQuestions,
            itemBuilder: (context, index) {
              bool isAnswered = answers.containsKey(index + 1);
              return InkWell(
                onTap: () {
                  setState(() => currentQuestion = index + 1);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentQuestion == index + 1
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
                      color: currentQuestion == index + 1 || isAnswered
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.school, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Assessment Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AssessmentReviewScreen()),
                          );
                        },
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: answers.length / totalQuestions,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionCard(
                      questionNumber: currentQuestion,
                      marks: 2,
                      content:
                          'Host A receives a frame and discards it after determining it is corrupt. Which OSI layer checks frames for errors?',
                      type: widget.type,
                      onAnswerSelected: (answer) {
                        setState(() {
                          answers[currentQuestion] = answer;
                        });
                      },
                      selectedAnswer: answers[currentQuestion],
                    ),
                  ],
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
                        onPressed: currentQuestion > 1
                            ? () => setState(() => currentQuestion--)
                            : null,
                        icon: Icon(Icons.chevron_left),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = -1; i <= 1; i++)
                            if (currentQuestion + i > 0 &&
                                currentQuestion + i <= totalQuestions)
                              GestureDetector(
                                onTap: () => setState(() =>
                                    currentQuestion = currentQuestion + i),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: i == 0
                                        ? Theme.of(context).primaryColor
                                        : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${currentQuestion + i}',
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
                        onPressed: currentQuestion < totalQuestions
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
    );
  }
}

class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final int marks;
  final String content;
  final AssessmentType type;
  final Function(dynamic) onAnswerSelected;
  final dynamic selectedAnswer;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.marks,
    required this.content,
    required this.type,
    required this.onAnswerSelected,
    this.selectedAnswer,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question $questionNumber',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Marks: $marks',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            if (type == AssessmentType.mcq) ...[
              for (int i = 1; i <= 4; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => onAnswerSelected(i),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedAnswer == i
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedAnswer == i
                              ? Theme.of(context).primaryColor
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
                                color: selectedAnswer == i
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[400]!,
                              ),
                            ),
                            child: selectedAnswer == i
                                ? Center(
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Option $i',
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedAnswer == i
                                  ? Theme.of(context).primaryColor
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ] else ...[
              ImageUploadSection(
                onImageSelected: onAnswerSelected,
                selectedImage: selectedAnswer,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ImageUploadSection extends StatelessWidget {
  final Function(dynamic) onImageSelected;
  final dynamic selectedImage;

  const ImageUploadSection({
    super.key,
    required this.onImageSelected,
    this.selectedImage,
  });

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Your answer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: selectedImage != null
                ? Image.file(
                    File(selectedImage.path),
                    fit: BoxFit.cover,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Upload your answer',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt),
                label: Text('Take Photo'),
              ),
              SizedBox(width: 16),
              TextButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo_library),
                label: Text('Upload from Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// review page

class AssessmentReviewScreen extends StatelessWidget {
  const AssessmentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Timer
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0288D1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '04:09',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Review Title
                    Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Questions Grid
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              // Simulate different states
                              QuestionStatus status;
                              if (index == 2 || index == 9 || index == 19) {
                                status = QuestionStatus.notAnswered;
                              } else if (index == 7 || index == 14) {
                                status = QuestionStatus.notVisited;
                              } else {
                                status = QuestionStatus.answered;
                              }

                              return QuestionStatusIndicator(
                                questionNumber: index + 1,
                                status: status,
                              );
                            },
                          ),

                          SizedBox(height: 24),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubmissionSuccessScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0288D1),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Submit Assessment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem(
                          icon: Icons.check_circle,
                          color: Colors.green,
                          label: 'Answered',
                        ),
                        SizedBox(width: 16),
                        _buildLegendItem(
                          icon: Icons.cancel,
                          color: Colors.red,
                          label: 'Not Answered',
                        ),
                        SizedBox(width: 16),
                        _buildLegendItem(
                          icon: Icons.radio_button_unchecked,
                          color: Colors.grey,
                          label: 'Not Visited',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

enum QuestionStatus {
  answered,
  notAnswered,
  notVisited,
}

class QuestionStatusIndicator extends StatelessWidget {
  final int questionNumber;
  final QuestionStatus status;

  const QuestionStatusIndicator({
    super.key,
    required this.questionNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (status) {
      case QuestionStatus.answered:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case QuestionStatus.notAnswered:
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case QuestionStatus.notVisited:
        icon = Icons.radio_button_unchecked;
        color = Colors.grey;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4),
        Text(
          'Ques. $questionNumber',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// submitted
class SubmissionSuccessScreen extends StatefulWidget {
  const SubmissionSuccessScreen({super.key});

  @override
  State<SubmissionSuccessScreen> createState() =>
      _SubmissionSuccessScreenState();
}

class _SubmissionSuccessScreenState extends State<SubmissionSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Check Mark
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        size: 80,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Success Text
                const Text(
                  'Submitted Successfully',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                // Assessment Title
                const Text(
                  'Assessment Title',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // Teacher Info
                const Text(
                  'is sent to',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Teacher Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                // Waiting Message
                const Text(
                  'Wait for the assessment to be marked',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
