// Onboarding Screen
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Change the type to List<String> for images
  final List<Map<String, dynamic>> onboardingPages = [
    {
      'title': 'Welcome to FlavorFi',
      'description': 'Discover personalized recipes based on your ingredients',
      'images': [
        'lib/assets/images/cooking.jpeg',
        'lib/assets/images/diet.jpg',
        'lib/assets/images/ingredients.jpeg',
        'lib/assets/images/healthy-diet.jpg'
      ]
    },
    {
      'title': 'Smart Ingredient Search',
      'description': 'Find recipes using ingredients you already have',
      'images': [
        'lib/assets/images/cooking.jpeg',
        'lib/assets/images/diet.jpg',
        'lib/assets/images/ingredients.jpeg',
        'lib/assets/images/healthy-diet.jpg'
      ]
    },
    {
      'title': 'Customize Your Diet',
      'description': 'Set your dietary preferences and health goals',
      'images': [
        'lib/assets/images/cooking.jpeg',
        'lib/assets/images/diet.jpg',
        'lib/assets/images/ingredients.jpeg',
        'lib/assets/images/healthy-diet.jpg',
      ]
    }
  ];

  List<String> dietPreferences = [
    'Vegan', 'Vegetarian', 'Gluten Free',
    'Keto', 'Paleo', 'Low Carb'
  ];

  Set<String> selectedDiets = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back Button for Navigation
            Row(
              children: [
                if (_currentPage > 0)
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut
                      );
                    },
                  ),
              ],
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    title: onboardingPages[index]['title']!,
                    description: onboardingPages[index]['description']!,
                    imagePaths: onboardingPages[index]['images']!,
                  );
                },
              ),
            ),

            // Dietary Preferences Selection
            if (_currentPage == 2) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select Your Dietary Preferences',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: dietPreferences.map((diet) {
                    return FilterChip(
                      label: Text(diet),
                      selected: selectedDiets.contains(diet),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            selectedDiets.add(diet);
                          } else {
                            selectedDiets.remove(diet);
                          }
                        });
                      },
                      deleteIcon: selectedDiets.contains(diet) ? Icon(Icons.close) : null,
                      onDeleted: selectedDiets.contains(diet)
                          ? () {
                        setState(() {
                          selectedDiets.remove(diet);
                        });
                      }
                          : null,
                    );
                  }).toList(),
                ),
              ),
            ],

            // Navigation Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  onboardingPages.length,
                      (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 10,
                    height: _currentPage == index ? 12 : 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.deepPurple
                            : Colors.grey.shade400
                    ),
                  )
              ),
            ),

            // Next/Start Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  if (_currentPage < onboardingPages.length - 1) {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut
                    );
                  } else {
                    // Navigate to Home Screen
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => HomeScreen(
                                selectedDiets: selectedDiets.toList()
                            )
                        )
                    );
                  }
                },
                child: Text(
                  _currentPage < onboardingPages.length - 1 ? 'Next' : 'Get Started',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingPageWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<String> imagePaths;

  const OnboardingPageWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePaths,
  }) : super(key: key);

  @override
  _OnboardingPageWidgetState createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.4,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 0.8,
            enlargeCenterPage: true,
          ),
          items: widget.imagePaths.map((imagePath) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 32),
        Text(
          widget.title,
          style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        )
      ],
    );
  }
}