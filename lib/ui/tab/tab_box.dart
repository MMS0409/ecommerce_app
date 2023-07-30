import 'package:flutter/material.dart';
import '../../utils/colors/app_colors.dart';
import '../basket/basket_screen.dart';
import '../category/category_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentTabIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(const HomeScreen());
    screens.add(const CategoryScreen());
    screens.add(const BasketScreen());
    screens.add(const ProfileScreen());
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTabIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.c_111015,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '',),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: '',),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '',),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '',),
          ],
          currentIndex: currentTabIndex,
          onTap: _onItemTapped,
        ),
      )
    );
  }
}
