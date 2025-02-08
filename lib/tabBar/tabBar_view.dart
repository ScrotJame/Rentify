import 'package:flutter/material.dart';
import 'package:rentify/home_page/home_page_view.dart';
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
          NavigationDestination(icon :Icon(Icons.search), label: 'kham pha'),
          NavigationDestination(icon: Badge(
            child: Icon(Icons.favorite),
            label: Text('thong bao'),
          ),
            label: 'Danh sach yeu thich',
          ),
          NavigationDestination(icon :Icon(Icons.home), label: 'home'),
          NavigationDestination(icon :Icon(Icons.messenger), label: 'tin nhan '),
          NavigationDestination(icon :Icon(Icons.account_circle_outlined), label: 'tai khoan'),
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


