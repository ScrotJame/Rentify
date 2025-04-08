import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/common/enum/drawer_item.dart';
import 'package:rentify/page/property/home_page_view.dart';
import 'package:rentify/widget/sreach_bar.dart';

import '../../main_cubit.dart';
import '../page/lease/lease_page.dart';
import '../page/user/user_page.dart';
//import '../page/user/profile_page.dart';


class PageMain extends StatelessWidget { // Callback để thông báo khi chọn tab
  static const String route= '/pagemain';
  PageMain({
    super.key,
  });
  int selectedIndex =2;
  Widget build(BuildContext context) {
    return  BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final pages = [
          LeasePage(),
          Container( child: Text('Favorite-đang cập nhật')),
          HomePageView(), // Tab Home hiển thị HomePageView
          Container(child: Text('Message-đang cập nhật')),
          UserPage(),
          //UserProfilePage(),
        ];

        return Scaffold(
          backgroundColor: Color(0xFFFFEEDB),
          appBar: AppBar(
            backgroundColor: Color(0xFFFFEEDB),
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
                icon: Icon(state.isLightTheme ? Icons.dark_mode : Icons.light_mode),
                onPressed: () => context.read<MainCubit>().toggleTheme(),
              ),
            ],
          ),
          body: pages[state.selected.index], // Hiển thị tab theo selected
          bottomNavigationBar: NavigationBar(
            height: 55,
            backgroundColor: Color(0xFFFFEEDB),
            selectedIndex: state.selected.index,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'House'),
              NavigationDestination(
                icon: Badge(child: Icon(Icons.favorite), label: Text('1')),
                label: 'Favorite',
              ),
              NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
              NavigationDestination(icon: Icon(Icons.messenger), label: 'Message'),
              NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: 'User'),
            ],
            onDestinationSelected: (int index) {
              context.read<MainCubit>().changeTab(TabItem.values[index]);
            },
          ),
        );
      },
    );
  }
}


