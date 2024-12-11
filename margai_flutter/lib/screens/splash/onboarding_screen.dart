import 'package:flutter/material.dart';
import 'package:margai_flutter/screens/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showArrows = false;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      logo: 'assets/images/logo.png',
      title: '',
      description: '',
      image: null,
      backgroundColor: const Color(0xFF2196F3),
      isLogoScreen: true,
    ),
    OnboardingItem(
      title: 'Give Assessments\nOnline',
      description: '',
      image: 'assets/images/women_laptop.png',
      backgroundColor: Colors.white,
    ),
    OnboardingItem(
      title: 'Inclusive for All',
      description: '',
      image: 'assets/images/twokids.png',
      backgroundColor: Colors.white,
    ),
    OnboardingItem(
      title: 'Get Exam Reports\nand Analytics',
      description: '',
      image: 'assets/images/scholars.png',
      backgroundColor: Colors.white,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward().then((_) {
      setState(() {
        _showArrows = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                item: _items[index],
                scaleAnimation: _scaleAnimation,
                showArrows: _showArrows,
              );
            },
          ),
          if (_currentPage < _items.length - 1 && _showArrows)
            Positioned(
              bottom: 40,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF2196F3),
                child: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (_currentPage == _items.length - 1 && _showArrows)
            Positioned(
              bottom: 40,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF2196F3),
                child: const Icon(Icons.check),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String? logo;
  final String title;
  final String description;
  final String? image;
  final Color backgroundColor;
  final bool isLogoScreen;

  OnboardingItem({
    this.logo,
    required this.title,
    required this.description,
    this.image,
    required this.backgroundColor,
    this.isLogoScreen = false,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final Animation<double> scaleAnimation;
  final bool showArrows;

  const OnboardingPage({
    Key? key,
    required this.item,
    required this.scaleAnimation,
    required this.showArrows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (item.isLogoScreen)
              ScaleTransition(
                scale: scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Image.asset(
                    item.logo!,
                    height: 420,
                  ),
                ),
              )
            else ...[
              const SizedBox(height: 40),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  item.image!,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
