import 'package:margai_flutter/imports.dart';

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
            child: Icon(Icons.school, color: Color(0xFF2196F3)),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.network(
                'https://ashutosh7i.dev/logo512.png',
                // color: Color(0xFF2196F3)
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
