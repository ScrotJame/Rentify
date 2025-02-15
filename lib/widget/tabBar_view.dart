import 'package:flutter/material.dart';
import 'package:rentify/page/home_page_view.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageState();
}



class _PageState extends State<PageMain> {
  int selectedIndex =2;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: [
        Container(child: Text('home'),
          ),
        Container(child: Text('tim kiem'),
          ),
        Container( child: HomePageView(),
          ),
        Container(child: Text('tin nhan'),
          ),
        Container(child: Text('ho so'),
        ),]

      [selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(icon :Icon(Icons.search), label: 'Travel'),
          NavigationDestination(icon: Badge(
            child: Icon(Icons.favorite),
            label: Text('1'),
          ),
            label: 'Favorite',
          ),
          NavigationDestination(icon :Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon :Icon(Icons.messenger), label: 'Message'),
          NavigationDestination(icon :Icon(Icons.account_circle_outlined), label: 'User'),
        ],
        onDestinationSelected: (value){
          setState(() {
            selectedIndex= value;
          });
        },
      ),
    );
  }
}


