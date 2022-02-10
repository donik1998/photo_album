// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:photo_album/presentation/profile/profile_page.dart';
// import 'package:titled_navigation_bar/titled_navigation_bar.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _pageIndex = 0;
//
//   List<Widget> _tabs = [
//     Container(),
//     Container(),
//     ProfilePage(),
//   ]
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _tabs.elementAt(_pageIndex),
//       bottomNavigationBar: TitledBottomNavigationBar(
//         currentIndex: _pageIndex,
//         onTap: (value) => setState(() => _pageIndex = value),
//         items: [
//           TitledNavigationBarItem(icon: SvgPicture.asset('assets/sgvs/home.svg'), title: title)
//         ],
//       ),
//     );
//   }
// }
