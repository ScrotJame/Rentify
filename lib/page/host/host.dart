import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/main_cubit.dart';
import 'package:rentify/page/user/user_page.dart';

import '../../common/enum/drawer_item.dart';
import '../../widget/custom_nav_bar.dart';
import 'room_manager/room_manager_page.dart';

class HostMain extends StatelessWidget {
  static const String route = '/hostmain';

  HostMain({ super.key,});

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit()..changeTab(TabItem.home),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final pages = [
            Container(child: Text('Message-đang cập nhật')),
            Container(child: Text('Message-đang cập nhật')),
            // ignore: prefer_const_constructors
            RoomManagerPage(),
            Container(child: Text('Message-đang cập nhật')),
            UserPage(),
          ];
          return Scaffold(
            body: pages[state.selected.index],
            bottomNavigationBar: LodgeBottomNavBar(
              selectedIndex: state.selected.index,
              onTabSelected: (int index) {
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
              // centerIcon đại diện cho Tab 2: Explore
              centerIcon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            //bottomNavigationBar: CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}

class HostBody extends StatelessWidget {
  const HostBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
