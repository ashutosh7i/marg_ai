import 'package:margai_flutter/imports.dart';

class AssignmentSubmissionPage extends StatefulWidget {
  const AssignmentSubmissionPage({super.key});

  @override
  State<AssignmentSubmissionPage> createState() =>
      _AssignmentSubmissionPageState();
}

class _AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
  final List<File?> _images = List.generate(3, (_) => null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _images[index] = File(image.path);
      });
    }
  }

  void _showImagePickerOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Click a picture'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(index, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Upload from device'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(index, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.assignment,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assignment 3',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Science Teacher',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle submission
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                        'Students, your assignment for this week is based on Chapter 3 of your Science textbook. Please review the concepts covered in this chapter and complete the following tasks:',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Text('1. Write a summary of the main topics discussed.'),
                      SizedBox(height: 8),
                      Text(
                          '2. Answer the questions at the end of the chapter (Exercises 1-5).'),
                      SizedBox(height: 8),
                      Text(
                          '3. Create a small poster or diagram illustrating one key concept from the chapter.'),
                      SizedBox(height: 16),
                      Text(
                        'Submit your work by Friday. Make sure your answers are clear and your poster is creative!',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your work',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(3, (index) {
                          return InkWell(
                            onTap: () => _showImagePickerOptions(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _images[index] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        _images[index]!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          size: 32,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Image-$index',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt, size: 20),
                          TextButton(
                            onPressed: () => _showImagePickerOptions(
                              _images.indexWhere((image) => image == null),
                            ),
                            child: const Text('Click a picture'),
                          ),
                          const Text('or'),
                          const Icon(Icons.upload, size: 20),
                          TextButton(
                            onPressed: () => _showImagePickerOptions(
                              _images.indexWhere((image) => image == null),
                            ),
                            child: const Text('Upload from device'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Deadline: 24/11/2024',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
