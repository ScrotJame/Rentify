import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/bean/property.dart';
import 'package:rentify/page/item_explore.dart';
import 'package:rentify/viewmodel/home_page_modelview.dart';
import '../viewmodel/image_property_viewmodel.dart';
import '../widget/img_widget.dart';
import 'detail/detailpage.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PropertyViewModel>(context, listen: false).fetchAllProperty();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Reset dữ liệu nếu cần khi widget bị hủy (optional)
    Provider.of<PropertyViewModel>(context, listen: false).reset(); // Giả sử có phương thức reset
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bất động sản'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ImagesProorety(), // Cung cấp ImagesProorety ở đây
        child: const BodyHomePage2(),
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
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            width: 200,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
          ),
          Container(
            width: 200,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red,
            ),
          ),
          Container(
            width: 200,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
          ),
          Container(
            width: 200,
            height: 400,
            decoration: BoxDecoration(
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
  const BodyHomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.errorMessage != null) {
          return Center(child: Text('Lỗi: ${viewModel.errorMessage}'));
        } else if (viewModel.allproperties.isEmpty) {
          return const Center(child: Text('Không có dữ liệu'));
        } else {
          print("Dữ liệu properties: ${viewModel.allproperties}");

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: viewModel.allproperties.length,
            itemBuilder: (context, index) {
              AllProperty property = viewModel.allproperties[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(propertyId: property.id,),
                    ),
                  );
                },
                child: AirbnbExploreItem2(
                  propertyId: property.id, // Sử dụng propertyId để tải ảnh
                  location: property.location,
                  title: property.title,
                  price: property.price,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10); // Thay Container bằng SizedBox cho đơn giản
            },
          );
        }
      },
    );
  }
}

class PreviewDetail extends StatelessWidget {
  const PreviewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AirbnbExploreItem2 extends StatefulWidget {
  final int propertyId; // Chỉ giữ propertyId
  final String location;
  final String title;
  final String price;

  const AirbnbExploreItem2({
    Key? key,
    required this.propertyId,
    required this.location,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  _AirbnbExploreItem2State createState() => _AirbnbExploreItem2State();
}

class _AirbnbExploreItem2State extends State<AirbnbExploreItem2> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: ImgWidget(propertyId: widget.propertyId), // Sử dụng ImgWidget
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(widget.location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text('VND ${widget.price}/month', style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}