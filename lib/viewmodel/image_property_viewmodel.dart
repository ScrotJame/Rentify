import 'package:flutter/material.dart';
import '../bean/property_image.dart';
import 'package:rentify/http/API.dart';

class ImagesProorety extends ChangeNotifier{
  List<PropertyImage> _propertyImages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PropertyImage> get propertyImages => _propertyImages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> fetchPropertyImages(int propertyId) async {

    _errorMessage = null;
   try{
        _propertyImages = await API.fetchPropertyImages(propertyId);
        print("Dữ liệu API trả về: $_propertyImages");
   }
   catch(e){
     _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
   }
   finally {
     _isLoading = false;
     notifyListeners();
   }
  }

}