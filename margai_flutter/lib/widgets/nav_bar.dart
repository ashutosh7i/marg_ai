import 'package:margai_flutter/imports.dart';
import 'package:margai_flutter/screens/accessibility/accessibility_screen.dart';
import 'package:margai_flutter/widgets/chatbot.dart';

// Nav Bar/App Bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF2196F3),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const ChatbotModal(),
                );
              },
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.gif',
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.accessibility_new),
            tooltip: 'Accessibility Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccessibilityScreen(),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const ChatbotModal(),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.network(
                'https://ashutosh7i.dev/logo512.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
