import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  final PageController _pageController = PageController();

  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

 final List<Map<String, dynamic>> _pages = [
  {
    'color': '#ffe24e',
    'title': 'Hmmm, Healthy food',
    'image': 'assets/images/image1.png',
    'description': "A variety of foods made by the best chef. Ingredients are easy to find, all delicious flavors can only be found at cookbunda",
    'skip': true
  },
  {
    'color': '#a3e4f1',
    'title': 'Fresh Drinks, Stay Fresh',
    'image': 'assets/images/image2.png',
    'description': 'Not all food, we provide clear healthy drink options for you. Fresh taste always accompanies you',
    'skip': true
  },
  {
    'color': '#31b77a',
    'title': 'Let\'s Cooking',
    'image': 'assets/images/image3.png',
    'description': 'Are you ready to make a dish for your friends or family? create an account and cooks',
    'skip': false
  },
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return  IntroWidget(
                color: _pages[index]['color']!,
                title: _pages[index]['title']!,
                description: _pages[index]['description']!,
                image: _pages[index]['image']!,
                skip: _pages[index]['skip']!,
                onTap: onNextPage
              );
            }
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicatorTrue() {
    final String color;
    if(_activePage == 0){
      color = '#ffe24e';
    } else if(_activePage == 1){
      color = '#a3e4f1';
    }else {
      color = '#31b77a';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: hexToColor(color),
      ),
    );
  }

  Widget _indicatorFalse() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade300,
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];
    for(var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorTrue());
      } else {
        indicators.add(_indicatorFalse());
      }
    }

    return indicators;
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key, required this.color, required this.title, required this.description, required this.skip, required this.image, required this.onTap});

  final String color;
  final String title;
  final String description;
  final bool skip;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: hexToColor(color),
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.86,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.16,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children: [
                  const SizedBox(height: 62,),
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 16,),
                  Text(description, style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.grey), textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: skip
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed : () {},
                  child: const Text('Skip Now', style: TextStyle(color: Colors.black),),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: hexToColor(color),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.arrow_circle_right, color: Colors.white, size: 42,),
                  ),
                )
              ],)
            : SizedBox(
              height: 46,
              child: MaterialButton(
                color: hexToColor(color),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onPressed: () {},
                child: const Text('Get Started', style: TextStyle(color: Colors.white,),),
              ),
            )
          ),
        ),
      ],),
    );
  }
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
