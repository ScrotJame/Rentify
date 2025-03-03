import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/property/property_cubit.dart';
import '../../http/API.dart';
import '../../main_cubit.dart';
import '../../widget/Properties_list.dart';
import '../../widget/sreach_bar.dart';
import 'package:rentify/page/detail/detailpage.dart';
import 'package:rentify/page/item_explore.dart';

class HomePageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PropertyCubit(context.read<API>())
        ..fetchAllProperties(),
      child: BodyHomePage2(),
    );
  }
}

class BodyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Lỗi: ${state.error}'));
          }
          return BodyHomePage2();
        },
      ),
    );
  }
}

class BodyHomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }
        final properties = state.properties;
        return PropertyList(properties: properties);
      },
    );
  }
}


