import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rentify/page/host/room_management/room_management_page.dart';
import 'package:rentify/page/lease/lease_page.dart';
import 'package:rentify/page/login/register/register_page.dart';
import 'package:rentify/page/result/result_page.dart';
import 'package:rentify/page/search/search_page.dart';
import 'package:rentify/page/viewing/payment/payment_page.dart';
import 'package:rentify/widget/tabBar_view.dart';
import 'package:rentify/page/login/login_page.dart';
import  'page/detail/detailpage.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case RegisterScreen.route:
      return MaterialPageRoute(builder: (context) => RegisterScreen());

    case PageMain.route:
      return MaterialPageRoute(builder: (context) => PageMain());

    case SearchPage.route:
      return MaterialPageRoute(builder: (context) => SearchPage());

    case ResultPage.route:
    // ignore: prefer_const_constructors
      return MaterialPageRoute(builder: (context) => ResultPage());

    case DetailPage.route:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => DetailPage(id: id));

    case PaymentPage.route:
      return MaterialPageRoute(builder: (context) => PaymentPage());

    case LeasePage.route:
      return MaterialPageRoute(builder: (context) => LeasePage());

    case RoomManagementPage.route:
      return MaterialPageRoute(builder: (context) => RoomManagementPage());

    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
