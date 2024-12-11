import 'package:margai_flutter/imports.dart';

// Bottom NavBar
class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Resources'),
        BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.description), label: 'Results'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), label: 'Analytics'),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
