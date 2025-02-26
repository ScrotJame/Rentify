import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bean/property_image.dart';
import '../viewmodel/image_property_viewmodel.dart';

class ImgWidget extends StatefulWidget {
  final int propertyId;

  const ImgWidget({Key? key, required this.propertyId}) : super(key: key);

  @override
  _ImgWidgetState createState() => _ImgWidgetState();
}

class _ImgWidgetState extends State<ImgWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ImagesProorety>(context, listen: false)
          .fetchPropertyImages(widget.propertyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Consumer<ImagesProorety>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const SizedBox(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (viewModel.errorMessage != null) {
                return SizedBox(
                  height: 200.0,
                  child: Center(child: Text('Lỗi tải ảnh: ${viewModel.errorMessage}')),
                );
              } else if (viewModel.propertyImages.isEmpty) {
                return const SizedBox(
                  height: 200.0,
                  child: Center(child: Text('Không có ảnh')),
                );
              }

              return CarouselSlider(
                items: viewModel.propertyImages.map((propertyImage) {
                  return CachedNetworkImage(
                    imageUrl: propertyImage.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  height: 200.0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}