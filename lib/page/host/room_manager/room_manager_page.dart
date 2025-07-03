import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../http/API.dart';
import '../../../widget/Properties_list.dart';
import '../../../widget/custom_nav_bar.dart';
import '../../../widget/header_bar.dart';
import '../../property/property_cubit.dart';
import '../room_management/room_management_page.dart';

class RoomManagerPage extends StatelessWidget {
  static const String route= '/roommanager';
  const RoomManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Add_Room_Bar(context),
        body: RoomManagarBody(),
        //bottomNavigationBar: CustomBottomNavBar(),
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
          child: ContainerRoom(context),
      ),
    );
  }
}

class RoomManagerContain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChipStateGroup(context),
        SizedBox(height: 16,),
        BlocBuilder<PropertyCubit, PropertyState>(
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
        ),
      ],
    );
  }
}

Widget ContainerRoom(BuildContext context){
  return Column(
    children: [
      ChipStateGroup(context),
      SizedBox(height: 16),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xBDBDBDFF),
            width: 1,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
               onTap: () {
                 Navigator.pushNamed(context, RoomManagementPage.route);
                 }
               ,child: Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(
                       child:Column(
                         mainAxisSize: MainAxisSize.max,
                         crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisSize: MainAxisSize.max,
                           children: [
                             Text('Title room',
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 26),
                             ),
                             SizedBox(width: 10),
                             Container(
                               height: 24,
                               decoration: BoxDecoration(
                                 color: const Color(0xFF96705B),// mau theo status
                                 borderRadius: BorderRadius.circular(12),
                               ),
                               child:
                               Align(
                                 alignment: AlignmentDirectional(0, 0),
                                 child: Padding(
                                     padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                   child: 
                                   Text('status',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 16,
                                     color: const Color(0xFFFFFFFF),
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                           child: Text('Price',
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 16,
                               color: const Color(0xFF000000),
                             ),),
                         ),
                         Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                           child: Text('Service cost',
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 16,
                               color: const Color(0xFF000000),
                             ),),
                         ),
                       ],
                       ),
                   ),
                   //more action
                   Container(
                     width: 36,
                     height: 36,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.5),
                           spreadRadius: 1,
                           blurRadius: 3,
                         ),
                       ],
                     ),
                     child: IconButton(
                       icon: Icon(Icons.more_vert, size: 20),
                       onPressed: () {
                         // Xử lý khi nhấn
                       },
                       padding: EdgeInsets.zero,
                       splashRadius: 20,
                     ),
                   ),
                 ],
               
               ),
             ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Divider(
                  thickness: 1,
                  color: Color(0x818181FF),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 58,
                      height: 58,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl:"https://picsum.photos/400",
                        fit: BoxFit.cover,
                      ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child:Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: Text('Contact method',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text('Ngày bắt đầu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              Text('15-6-2024',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ]
                          ),
                          SizedBox(width: 16),
                          Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Ngày kết thúc',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                                Text('15-6-2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                      ]
                    ),
                  ),
                ]
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child:
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          child: Text(
                            "Nhắn tin",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Số tháng còn lại",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "11 tháng",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    ],
  );

}
Widget ChipStateGroup(BuildContext context){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF96705B),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'All Rooms',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 0.0,
                  )
                ),
                SizedBox(width: 5),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '12',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF96705B),
                            fontSize: 14,
                            letterSpacing: 0.0,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox( width: 10 ),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF96705B),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                    'All Rooms',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0.0,
                    )
                ),
                SizedBox(width: 5),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          '12',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF96705B),
                            fontSize: 14,
                            letterSpacing: 0.0,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}