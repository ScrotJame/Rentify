import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentify/firebase_options.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
          //Gioi han phan tu truoc
          itemCount: 10,
          itemBuilder:(context, index) =>Container
            (alignment: Alignment.center,
            width:  200,
            height: 400,margin: EdgeInsets.all(10),
            decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
        ),
            child: Text('Text $index'),
      ),
        separatorBuilder: (BuildContext context, int index) {
            return Container
              (alignment: Alignment.center,
              width:  200,
              height: 10,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
            );
        },
    ),
    );
  }
}
