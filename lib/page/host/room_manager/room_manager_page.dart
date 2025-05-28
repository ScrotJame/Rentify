import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../http/API.dart';
import '../../../widget/Properties_list.dart';
import '../../../widget/header_bar.dart';
import '../../property/property_cubit.dart';

class RoomManagerPage extends StatelessWidget {
  const RoomManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Add_Room_Bar(context),
        body: RoomManagarBody()
    );
  }
}

class RoomManagarBody extends StatelessWidget {
  const RoomManagarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PropertyCubit(context.read<API>())
        ..fetchAllPropertiesByOwner(),
      child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: RoomManagerContain(),
      ),
    );
  }
}

class RoomManagerContain extends StatelessWidget {
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
        final properties = state.propertiesByOwner;
        return PropertyByOwnerList(properties: properties);
      },
    );
  }
}


