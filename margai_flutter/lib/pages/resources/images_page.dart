import 'package:margai_flutter/imports.dart';

class ImageViewScreen extends StatelessWidget {
  final String imagePath;

  const ImageViewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Viewer')),
      body: Center(
        child: Image.network(imagePath),
      ),
    );
  }
}
