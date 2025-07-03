import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/property/property_cubit.dart';
import '../../http/API.dart';
import '../../widget/Properties_list.dart';

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


