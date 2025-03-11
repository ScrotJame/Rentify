import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/login/register/register_page.dart';
import 'package:rentify/page/result/result_page.dart';
import 'package:rentify/page/search/search_page.dart';
import 'package:rentify/widget/tabBar_view.dart';
import 'package:rentify/page/login/login_page.dart';
import  'page/detail/detailpage.dart';

Route<dynamic>? mainRoute(RouteSettings settings){
 switch(settings.name){
   case LoginScreen.route:
     return MaterialPageRoute(builder: (context) => LoginScreen());
   case RegisterScreen.route:
     return MaterialPageRoute(builder: (context)=> RegisterScreen());
   case PageMain.route:
     return MaterialPageRoute(builder: (context) => PageMain());
   case Search_Page.route:
     return MaterialPageRoute(builder: (context) => Search_Page());
   case ResultPage.route:
     return MaterialPageRoute(builder: (context) => ResultPage());
   case DetailPage.route:
     var Id;
     return MaterialPageRoute(builder: (context) => DetailPage(id: Id));
   default:
     return MaterialPageRoute(builder: (context) => LoginScreen());
 }
}