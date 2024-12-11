import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You ve reached 72% of your GOAL this week',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Performance Graph
              Container(
                height: 200,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Performance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Overall',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 3),
                                FlSpot(2.6, 2),
                                FlSpot(4.9, 5),
                                FlSpot(6.8, 3.1),
                                FlSpot(8, 4),
                                FlSpot(9.5, 3),
                                FlSpot(11, 4),
                              ],
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Top Performing Students
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Performing Student',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildStudentCard('AA', 'Abhishek Jha', Colors.yellow),
                    _buildStudentCard('A+', 'Madhav Arya', Colors.grey),
                    _buildStudentCard('OT', 'Olamileyi Toki', Colors.orange),
                    _buildStudentCard('MA', 'You', Colors.orange.shade200),
                  ],
                ),
              ),

              // Calendar
              Container(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: [8, 13, 18, 22].contains(index + 1)
                            ? Colors.blue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: [8, 13, 18, 22].contains(index + 1)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Upcoming Activities
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Activities',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('See all'),
                        ),
                      ],
                    ),
                    _buildActivityCard(
                      '8',
                      'Life Contingency Tutorials',
                      '24th July 2023 • 12:30 - 13:30',
                      Colors.blue,
                    ),
                    _buildActivityCard(
                      '13',
                      'Social Insurance Test',
                      '24th July 2023 • 12:30 - 13:30',
                      Colors.pink,
                    ),
                    _buildActivityCard(
                      '18',
                      'Adv. Maths Assignment Due',
                      '24th July 2023 • 12:30 - 13:30',
                      Colors.green,
                    ),
                    _buildActivityCard(
                      '22',
                      'Dr. Dipos Tutorial Class',
                      '24th July 2023 • 12:30 - 13:30',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(String grade, String name, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              grade,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
      String day, String title, String datetime, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              day,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  datetime,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
