import 'package:margai_flutter/imports.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedMetric = 'Overall';
  String selectedSubject = 'All Subjects';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Analytics',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Performance Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Performance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedMetric,
                            items: ['Overall', 'Unit Tests', 'Subject Wise']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedMetric = newValue;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      if (selectedMetric == 'Subject Wise')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: DropdownButton<String>(
                            value: selectedSubject,
                            items: [
                              'All Subjects',
                              'Science',
                              'Mathematics',
                              'Social Sciences'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedSubject = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 3),
                                  FlSpot(1, 1),
                                  FlSpot(2, 4),
                                  FlSpot(3, 2),
                                  FlSpot(4, 5),
                                ],
                                isCurved: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.withOpacity(0.5),
                                    Colors.blue,
                                  ],
                                ),
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.1),
                                      Colors.blue.withOpacity(0.2),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Completion Progress
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Completion Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SubjectProgress(
                        subject: 'Science',
                        chapter: 'Chapter 3',
                        progress: 0.75,
                        color: Colors.blue,
                      ),
                      SubjectProgress(
                        subject: 'Social Sciences',
                        chapter: 'Chapter 4',
                        progress: 0.45,
                        color: Colors.green,
                      ),
                      SubjectProgress(
                        subject: 'Mathematics',
                        chapter: 'Module 2',
                        progress: 0.25,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Additional Analytics
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detailed Statistics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildStatItem(
                        'Average Score',
                        '85%',
                        Icons.analytics,
                        Colors.blue,
                      ),
                      _buildStatItem(
                        'Assignments Completed',
                        '24/30',
                        Icons.assignment_turned_in,
                        Colors.green,
                      ),
                      _buildStatItem(
                        'Study Time',
                        '45 hours',
                        Icons.timer,
                        Colors.orange,
                      ),
                      _buildStatItem(
                        'Improvement',
                        '+15%',
                        Icons.trending_up,
                        Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectProgress extends StatelessWidget {
  final String subject;
  final String chapter;
  final double progress;
  final Color color;

  const SubjectProgress({
    super.key,
    required this.subject,
    required this.chapter,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  chapter,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              children: [
                CircularProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeWidth: 8,
                ),
                Center(
                  child: Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
