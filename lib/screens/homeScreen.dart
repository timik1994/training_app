// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:training_app/screens/cardioScreen.dart';
// import 'package:training_app/screens/powerScreen.dart';
// import 'package:training_app/screens/pressScreen.dart';
// import 'package:training_app/screens/rulerScreen.dart';
// import 'package:training_app/screens/statisticScreen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreen();
// }
//
// class _HomeScreen extends State<HomeScreen> {
//   final _pageController = PageController(initialPage: 0);
//   final NotchBottomBarController _bottomBarController =
//       NotchBottomBarController(index: 0);
//
//   int maxCount = 5;
//   int _selectedIndex = 0;
//
//   final List<Widget> bottomBarPages = [
//     CardioScreen(),
//     PowerScreen(),
//     PressScreen(),
//     RulerScreen(),
//    // StatisticScreen()
//   ];
//
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: List.generate(
//             bottomBarPages.length, (index) => bottomBarPages[index]),
//       ),
//       bottomNavigationBar:
//           (bottomBarPages.length <= maxCount) ? bottomNavBar() : null,
//     );
//   }
//
//   // нижняя навигационная панель
//   Widget bottomNavBar() {
//     return AnimatedNotchBottomBar(
//       notchBottomBarController: _bottomBarController,
//       // общий цвет нижней панели
//       color: Theme.of(context).colorScheme.background,
//       // показывать названия
//       showLabel: true,
//       // цвет выделенного элемента
//       notchColor: Theme.of(context).primaryColorDark,
//       bottomBarItems: const [
//         BottomBarItem(
//           inActiveItem: Icon(
//             FontAwesomeIcons.heartPulse,
//             color: Colors.blue,
//           ),
//           activeItem: Icon(
//               FontAwesomeIcons.heartPulse,
//               color: Colors.white,
//           ),
//           //itemLabel: 'Кардио',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(
//             FontAwesomeIcons.dumbbell,
//             color: Colors.cyan,
//           ),
//           activeItem: Icon(
//             FontAwesomeIcons.dumbbell,
//             color: Colors.white,
//           ),
//           //itemLabel: 'Силовые',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(
//             FontAwesomeIcons.stopwatch20,
//             color: Colors.yellow,
//           ),
//           activeItem: Icon(
//             FontAwesomeIcons.stopwatch20,
//             color: Colors.white,
//           ),
//           // itemLabel: 'Пресс',
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(
//             FontAwesomeIcons.ruler,
//             color: Colors.orange,
//           ),
//           activeItem: Icon(
//             FontAwesomeIcons.ruler,
//             color: Colors.white,
//           ),
//           // itemLabel: 'Измерения',
//         ),
//         // BottomBarItem(
//         //   inActiveItem: Icon(
//         //     FontAwesomeIcons.chartSimple,
//         //     color: Colors.green,
//         //   ),
//         //   activeItem: Icon(
//         //     FontAwesomeIcons.chartSimple,
//         //     color: Colors.white,
//         //   ),
//         //   // itemLabel: 'Статистика',
//         // ),
//       ],
//       onTap: (index) {
//         setState(() {
//           _selectedIndex = index;
//         });
//
//         // при нажатии на иконку в нижнем баре происходит анимированный переход к другому экрану
//         _pageController.animateToPage(
//           index,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.decelerate,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_app/screens/cardioScreen.dart';
import 'package:training_app/screens/powerScreen.dart';
import 'package:training_app/screens/pressScreen.dart';
import 'package:training_app/screens/rulerScreen.dart';
import 'package:training_app/screens/statisticScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    CardioScreen(),
    PowerScreen(),
    PressScreen(),
    RulerScreen(),
    StatisticScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heartPulse, color: Colors.cyan),
            label: 'Кардио',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.weightHanging, color: Colors.grey),
            label: 'Силовые',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.stopwatch20, color: Colors.blue),
            label: 'Пресс',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.ruler, color: Colors.orange),
            label: 'Измерения',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartSimple, color: Colors.green),
            label: 'Статистика',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        onTap: _onItemTapped,
      ),
    );
  }
}

