import 'package:margai_flutter/imports.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resources',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTypeButton('All'),
                    _buildTypeButton('Documents'),
                    _buildTypeButton('Videos'),
                    _buildTypeButton('Assignments'),
                    _buildTypeButton('Images'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: _getFilteredResources(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedType = type;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedType == type ? Colors.blue : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: _selectedType == type ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  List<Widget> _getFilteredResources() {
    if (_selectedType == 'All') {
      return [
        ...renderAssignments(context),
        ...renderDocuments(),
        ...renderVideos(),
        ...renderImages(),
      ];
    } else if (_selectedType == 'Assignments') {
      return renderAssignments(context);
    } else if (_selectedType == 'Documents') {
      return renderDocuments();
    } else if (_selectedType == 'Videos') {
      return renderVideos();
    } else if (_selectedType == 'Images') {
      return renderImages();
    }
    return [];
  }

  List<Widget> renderAssignments(BuildContext context) {
    return [
      render_assignment(
        context: context,
        title: 'Assignment 1',
        subtitle: 'English Teacher',
        metadata: 'Deadline: 24/11/2024',
        metadataColor: Colors.red,
        isCompleted: false,
      ),
      render_assignment(
        context: context,
        title: 'Assignment 1',
        subtitle: 'Maths Teacher',
        metadata: 'Deadline: 22/11/2024',
        metadataColor: Colors.red,
        isCompleted: true,
      ),
    ];
  }

  List<Widget> renderDocuments() {
    return [
      render_document(
        context: context,
        title: 'Chapter 4 Notes',
        subtitle: 'Maths Teacher',
        metadata: 'chapterfour.pdf',
        pdfUrl: 'https://ashutosh7i.dev/resume/resume.pdf',
      ),
    ];
  }

  List<Widget> renderVideos() {
    return [
      render_video(
        context: context,
        title: 'Science Exp 2 Video',
        subtitle: 'Science Teacher',
        metadata: 'video2nd.mp4',
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    ];
  }

  List<Widget> renderImages() {
    return [
      render_image(
        context: context,
        title: 'Biology Diagram',
        subtitle: 'Biology Teacher',
        metadata: 'diagram.jpg',
        imagePath:
            'https://media.geeksforgeeks.org/wp-content/uploads/20240327171054/Food-Chain.png',
      ),
    ];
  }

// function to render assignment card
  Widget render_assignment({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String metadata,
    required Color metadataColor,
    required bool isCompleted,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentSubmissionPage(),
          ),
        );
      },
      child: ResourceCard(
        icon: Icons.assignment,
        title: title,
        subtitle: subtitle,
        metadata: metadata,
        metadataColor: metadataColor,
        trailing: CircleAvatar(
          backgroundColor: isCompleted ? Color(0xFF4CAF50) : Color(0xFFFF4444),
          radius: 15,
          child: Icon(
            isCompleted ? Icons.check : Icons.notification_important,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget render_document({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String metadata,
    required String pdfUrl,
  }) {
    return GestureDetector(
      onTap: () async {
        try {
          String remotePDFpath = await createFileOfPdfUrl(pdfUrl);
          if (remotePDFpath.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreen(path: remotePDFpath),
              ),
            );
          }
        } catch (e) {
          print("Error loading PDF: $e");
          // Handle error (e.g., show a snackbar)
        }
      },
      child: ResourceCard(
        icon: Icons.description,
        title: title,
        subtitle: subtitle,
        metadata: metadata,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.book, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Future<File> createFileOfPdfUrl(String url) async {
  //   Completer<File> completer = Completer();
  //   print("Start download file from internet!");
  //   try {
  //     final filename = url.substring(url.lastIndexOf("/") + 1);
  //     var request = await HttpClient().getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     var bytes = await consolidateHttpClientResponseBytes(response);
  //     var dir = await getApplicationDocumentsDirectory();
  //     print("Download files");
  //     print("${dir.path}/$filename");
  //     File file = File("${dir.path}/$filename");

  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

  Widget render_video({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String metadata,
    required String videoUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
          ),
        );
      },
      child: ResourceCard(
        icon: Icons.play_circle_outline,
        title: title,
        subtitle: subtitle,
        metadata: metadata,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.play_arrow, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget render_image({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String metadata,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageViewScreen(imagePath: imagePath),
          ),
        );
      },
      child: ResourceCard(
        icon: Icons.image,
        title: title,
        subtitle: subtitle,
        metadata: metadata,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.visibility, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// function to render card body
class ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String metadata;
  final Color metadataColor;
  final Widget trailing;

  const ResourceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.metadata,
    this.metadataColor = Colors.grey,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    metadata,
                    style: TextStyle(
                      fontSize: 14,
                      color: metadataColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            trailing,
          ],
        ),
      ),
    );
  }
}
