import 'package:flutter/material.dart';
import 'package:margai_flutter/imports.dart';
import 'package:margai_flutter/pages/tasks/test.dart';

class ExamResultScreen extends StatelessWidget {
  final ExamResult result;

  const ExamResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Results'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultSummary(),
            SizedBox(height: 24),
            _buildQuestionResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Final Score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CircularPercentIndicator(
              radius: 80,
              lineWidth: 12,
              percent: result.percentage / 100,
              center: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${result.percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Grade: ${result.grade}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              progressColor: _getColorForPercentage(result.percentage),
              backgroundColor: Colors.grey[200]!,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total Questions',
                  result.totalQuestions.toString(),
                  Icons.quiz,
                ),
                _buildStatItem(
                  'Correct Answers',
                  result.correctAnswers.toString(),
                  Icons.check_circle,
                ),
                _buildStatItem(
                  'Incorrect',
                  (result.totalQuestions - result.correctAnswers).toString(),
                  Icons.cancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question Analysis',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...result.questionResults.map((qResult) => _buildQuestionResultCard(qResult)),
      ],
    );
  }

  Widget _buildQuestionResultCard(QuestionResult qResult) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
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
                Icon(
                  qResult.isCorrect ? Icons.check_circle : Icons.cancel,
                  color: qResult.isCorrect ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    qResult.question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildAnswerRow('Your Answer:', qResult.userAnswer),
            if (qResult.correctAnswer != null)
              _buildAnswerRow('Correct Answer:', qResult.correctAnswer!),
            if (qResult.feedback != null) ...[
              SizedBox(height: 8),
              Text(
                'Feedback:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              Text(qResult.feedback!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerRow(String label, String answer) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(answer),
          ),
        ],
      ),
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 