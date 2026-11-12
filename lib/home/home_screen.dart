import 'dart:math';

import 'package:busola_app/home/test_page.dart';
import 'package:busola_app/home/trening_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final void Function(dynamic tr) sendToParent;
  const HomeScreen({
    super.key,
    required this.sendToParent,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pc = PageController();

  int _pageIndex = 0;
  void _changePage(int index) {
    setState(() {
      _pageIndex = index;
      _pc.animateToPage(_pageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:
              Transform.rotate(angle: pi / 2, child: const Icon(Icons.explore)),
          title: const Text("Busola App"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.4, 0.6],
                colors: [
                  Color.fromRGBO(236, 104, 27, 1),
                  Color.fromRGBO(242, 137, 21, 1)
                ],
              ),
            ),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Opacity(
            opacity: 0.3,
            child: Image(image: AssetImage("lib/assets/images/busola.png")),
          ),
          PageView(
            controller: _pc,
            onPageChanged: (index) => setState(() {
              _pageIndex = index;
            }),
            children: [
              const TestPage(),
              TreningPage(sendToParent: widget.sendToParent)
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Test"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Trening"),
        ],
      ),
    );
  }
}
