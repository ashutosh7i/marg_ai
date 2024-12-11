import 'package:margai_flutter/imports.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Results',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Midterm Section
                ResultSection(
                  title: 'Midterm',
                  showAllColumns: true,
                  status: ExamStatus.resultsDeclared,
                  grades: [
                    Grade(
                        subject: 'Subject 1',
                        assignment: 'A+/96',
                        viva: 'A+/96',
                        term: 'A+/96'),
                    Grade(
                        subject: 'Subject 2',
                        assignment: 'A/90',
                        viva: 'A/90',
                        term: 'A/90'),
                    Grade(
                        subject: 'Subject 3',
                        assignment: 'A-/84',
                        viva: 'A-/84',
                        term: 'A-/84'),
                    Grade(
                        subject: 'Subject 4',
                        assignment: 'A+/85',
                        viva: 'A+/85',
                        term: 'A+/96'),
                    Grade(
                        subject: 'Subject 5',
                        assignment: 'A/90',
                        viva: 'A/90',
                        term: 'A/90'),
                  ],
                ),

                const SizedBox(height: 24),

                // Pre-Board Section
                ResultSection(
                  title: 'Pre-Board',
                  showAllColumns: false,
                  status: ExamStatus.underProgress,
                  grades: [],
                ),

                const SizedBox(height: 24),

                // Final Section
                ResultSection(
                  title: 'Final',
                  showAllColumns: false,
                  status: ExamStatus.yetToBegin,
                  grades: [],
                ),

                const SizedBox(height: 24),

                // Remarks Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Remarks by Class Teacher',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Thanks for a fantastic year at school this year! It\'s been awesome to see everyone grow and develop so much and our community has come together in such a special way. You\'ve all done amazing work in your projects and activities. Hope you all have a fantastic summer, and I\'m looking forward to seeing everyone back in the fall.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '~ Mr. John Doe',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
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

class Grade {
  final String subject;
  final String? assignment;
  final String? viva;
  final String term;

  Grade({
    required this.subject,
    this.assignment,
    this.viva,
    required this.term,
  });
}

enum ExamStatus {
  yetToBegin,
  underProgress,
  resultsDeclared,
}

class ResultSection extends StatelessWidget {
  final String title;
  final bool showAllColumns;
  final List<Grade> grades;
  final ExamStatus status;

  const ResultSection({
    super.key,
    required this.title,
    required this.showAllColumns,
    required this.grades,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            _buildStatusChip(),
          ],
        ),
        const SizedBox(height: 12),
        if (status == ExamStatus.resultsDeclared)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Subject',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      if (showAllColumns) ...[
                        Expanded(
                          child: Text(
                            'Assignments',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Viva',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                      Expanded(
                        child: Text(
                          showAllColumns ? 'Term I' : 'Final',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Grades
                ...grades
                    .map((grade) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(grade.subject),
                              ),
                              if (showAllColumns) ...[
                                Expanded(
                                  child: Text(grade.assignment ?? '-'),
                                ),
                                Expanded(
                                  child: Text(grade.viva ?? '-'),
                                ),
                              ],
                              Expanded(
                                child: Text(grade.term),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                // GPA
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'GPA: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.21',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            // child: Center(
            //   child: _buildStatusChip(),
            // ),
          ),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    String statusText;

    switch (status) {
      case ExamStatus.yetToBegin:
        chipColor = Colors.white;
        statusText = 'Yet to Begin';
        break;
      case ExamStatus.underProgress:
        chipColor = Colors.yellow;
        statusText = 'Under Progress';
        break;
      case ExamStatus.resultsDeclared:
        chipColor = Colors.green;
        statusText = 'Results Declared';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: status == ExamStatus.yetToBegin ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
