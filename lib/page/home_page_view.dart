// home_page_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/bean/property.dart';
import 'package:rentify/viewmodel/home_page_modelview.dart';
import 'package:rentify/page/detail/detailpage.dart';
import 'package:rentify/page/item_explore.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    // Gọi fetchProperties khi widget được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PropertyViewModel>(context, listen: false).fetchProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bất động sản'),
      ),
      body: Consumer<PropertyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Lỗi: ${viewModel.errorMessage}'));
          } else if (viewModel.properties.isEmpty) {
            return const Center(child: Text('Không có dữ liệu'));
          } else {
            return ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: viewModel.properties.length,
              itemBuilder: (context, index) {
                DetailProperty property = viewModel.properties[index];
                return GestureDetector(
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
                    imageUrl: property.imageUrl,
                    location: property.location,
                    title: property.title,
                    price: property.price,
                    rating: property.rating,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 10,
                );
              },
            );
          }
        },
      ),
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

// class BodyHomePage2 extends StatelessWidget {
//   const BodyHomePage2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 450,
//       child: ListView.separated(
//         padding: EdgeInsets.all(20),
//         itemCount: 10,
//         itemBuilder: (context, index) => GestureDetector(
//           onTap: () {
//             // go to detailpage
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DetailPage(index: index),
//               ),
//             );
//           },
//            child: AirbnbExploreItem2(
//              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
//              location: 'Ho Chi Minh City, Vietnam',
//              title: 'Modern Apartment Downtown',
//              price: 75.50,
//              rating: 4.7,),
//         ),
//         separatorBuilder: (BuildContext context, int index) {
//           return Container(
//             alignment: Alignment.center,
//             width: 200,
//             height: 10,
//           );
//         },
//       ),
//     );
//   }
// }

class PreviewDetail extends StatelessWidget {
  const PreviewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
