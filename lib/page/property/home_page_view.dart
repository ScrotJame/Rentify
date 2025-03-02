import 'package:flutter/material.dart';
import '../widget/sreach_bar.dart';
import 'package:rentify/page/detailpage.dart';
import 'package:rentify/page/item_explore.dart';
class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 0),
          child: SearchBar(),
        ),toolbarHeight: 100,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BodyHomePage2(),
    );
  }
}

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.all(20),
    child: ListView(
      children: [
        Container(width:  200,height: 400, decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        ),Container(width:  200,height: 400, decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        ),Container(width:  200,height: 400, decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        ),Container(width:  200,height: 400, decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        ),
      ],
    ),
    );
  }
}

class BodyHomePage2 extends StatelessWidget {
  const BodyHomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 450,
      child: ListView.separated(
        padding: EdgeInsets.all(20),
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // go to detailpage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(index: index),
              ),
            );
          },
           child: AirbnbExploreItem2(
             imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
             location: 'Ho Chi Minh City, Vietnam',
             title: 'Modern Apartment Downtown',
             price: 75.50,
             rating: 4.7,),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            width: 200,
            height: 10,
          );
        },
      ),
    );
  }
}

class PreviewDetail extends StatelessWidget {
  const PreviewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
