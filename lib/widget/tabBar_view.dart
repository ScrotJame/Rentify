import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/common/enum/drawer_item.dart';
import 'package:rentify/page/property/home_page_view.dart';
import 'package:rentify/widget/header_bar.dart';
import '../../main_cubit.dart';
import '../page/favorite/favorite_page.dart';
import '../page/lease/lease_page.dart';
import '../page/user/user_page.dart';
import 'custom_nav_bar.dart';

class PageMain extends StatelessWidget {
  static const String route = '/pagemain';

  PageMain({
    super.key,
  });

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final pages = [
            // ignore: prefer_const_constructors
            LeasePage(),
            // ignore: prefer_const_constructors
            FavoritePage(),
            HomePageView(),
            // ignore: prefer_const_constructors
            Container(child: Text('Message-đang cập nhật')),
            UserPage(),
          ];

          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 16.0, 46.0, 10),
                  child: Search_Bar(),
                ),
              ),
              toolbarHeight: 65,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(
                      state.isLightTheme ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () => context.read<MainCubit>().toggleTheme(),
                ),
              ],
            ),
            body: pages[state.selected.index], // Hiển thị tab theo selected
            bottomNavigationBar: LodgeBottomNavBar(
              selectedIndex: state.selected.index,
              onTabSelected: (index) {
                context.read<MainCubit>().changeTab(TabItem.values[index]);
              },
              onCenterButtonPressed: () {
                context.read<MainCubit>().changeTab(TabItem.home);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'House',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                // Tab 2: Explore - sẽ được thay thế bằng centerIcon
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Explore',
                ),
                // Tab 3: Messenger với Badge
                BottomNavigationBarItem(
                  icon: Badge(
                    label: Text('1'),
                    child: Icon(Icons.messenger_outline),
                  ),
                  activeIcon: Badge(
                    label: Text('1'),
                    child: Icon(Icons.messenger),
                  ),
                  label: 'Messenger',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'User',
                ),
              ],
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF96705B),
              unselectedItemColor: Colors.grey,
              centerButtonColor: const Color(0xFF96705B),
              centerButtonSize: 60.0,
              iconSize: 24.0,
              centerIcon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageMainOwner extends StatelessWidget {
  const PageMainOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}