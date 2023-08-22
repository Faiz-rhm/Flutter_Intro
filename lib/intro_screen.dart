import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intro/intro_widget.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {


  final PageController  _pageController = PageController();

  int _activePage = 0;

  void onNextPage(){
    if(_activePage  < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,);
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
            scrollBehavior: AppScrollBehavior(),
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index){
              return IntroWidget(
                index: index,
                color: _pages[index]['color'],
                title: _pages[index]['title'],
                description: _pages[index]['description'],
                image: _pages[index]['image'],
                skip: _pages[index]['skip'],
                onTab: onNextPage,
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
                  children: _buildIndicator()
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators =  <Widget>[];

    for(var i = 0; i < _pages.length; i++) {

      if(_activePage == i) {
        indicators.add(_indicatorsTrue());
      }else{
        indicators.add(_indicatorsFalse());
      }
    }
    return  indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if(_activePage == 0){
      color = '#ffe24e';
    } else  if(_activePage ==  1) {
      color = '#a3e4f1';
    } else {
      color = '#31b77a';
    }

    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: hexToColor(color),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade100,
      ),
    );
  }
}