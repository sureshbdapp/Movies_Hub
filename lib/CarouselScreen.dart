import 'package:flutter/material.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  PageController pageController = PageController();
  final List<Widget> _list = <Widget>[
    Center(
      child: Text("Hello1"),
    ),
    Center(
      child: Text("Hello2"),
    ),
    Center(
      child: Text("Hello3"),
    ),
    Center(
      child: Text("Hello4"),
    ),
  ];
  int _curr = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          PageView(
            scrollDirection: Axis.horizontal,
            children: _list,
            controller: pageController,
            onPageChanged: (index) {
              _curr = index;
            },
          ),
          // DotsIndicator(
          //   dotsCount: items.length,
          //   position: currentIndex.toDouble(),
          // )
        ],
      ),
    ));
  }
}
