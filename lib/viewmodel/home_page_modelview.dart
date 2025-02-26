import 'package:flutter/material.dart';
import 'package:rentify/bean/property.dart';
import 'package:rentify/http/API.dart';
import '../bean/property_amenities.dart';
import '../bean/property_image.dart';

class PropertyViewModel extends ChangeNotifier {

  List<DetailProperty> _properties = [];
  List<AllProperty> _allproperties = [];
  List<PropertyAmenities> _propertyAmenities = [];
  List<PropertyImage> _propertyImages = [];
  List<String> _allAmenities = [];

  bool _isLoading = false;
  String? _errorMessage;

  DetailProperty? _selectedProperty;
  AllProperty? _AllProperty;

  List<DetailProperty> get properties => _properties;
  List<AllProperty> get allproperties => _allproperties;
  List<PropertyAmenities> get propertyAmenities => _propertyAmenities;
  List<PropertyImage> get propertyImages => _propertyImages;
  List<String> get allAmenities => _allAmenities;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  DetailProperty? get selectedProperty => _selectedProperty;


  Future<void> fetchProperties(int propertyId) async {
    _isLoading = true;
    _errorMessage = null;
    _AllProperty=null;
    notifyListeners(); // Cập nhật UI trước khi bắt đầu fetch

    try {
      // Gọi trực tiếp API.fetchProperties()
      _properties = await API
          .fetchProperties(propertyId);
    } catch (e) {
      _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners(); // Cập nhật UI sau khi fetch xong (thành công hoặc thất bại)
    }
  }
//  All Property
  Future<void> fetchAllProperty() async {
    _isLoading = true;
    _errorMessage = null;
    _allproperties = [];
    notifyListeners();
    try {
      _allproperties = await API.fetchAllProperty();
      print("Dữ liệu API trả về: $_allproperties");
      if (_allproperties.isNotEmpty) {
        print("Number of properties loaded: ${_allproperties.length}");
        // In dữ liệu chi tiết của từng AllProperty
        print("Dữ liệu API trả về:");
        for (var property in _allproperties) {

          print("  ID: ${property.id}");
          print("  Title: ${property.title}");
          print("  Location: ${property.location}");
          print("  Price: ${property.price}");
         for(var image in property.image){
           print("  Image: ${image.imageUrl}");
         }
        }
      } else {
        _errorMessage = 'No data';
        print("API Error: No data");
      }} catch (e) {
      // Xử lý lỗi cụ thể hơn nếu có thể
      _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


    Future<void> fetchAmentitiesProperty(int propertyId) async {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        // Lấy chi tiết bất động sản
        DetailProperty property = await API.fetchAmentitiesProperty(propertyId);
        // Lấy danh sách tiện ích từ chi tiết bất động sản
        _propertyAmenities = property.amenities;
      } catch (e) {
        // Xử lý lỗi cụ thể hơn nếu có thể
        _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  void reset() {
    _allproperties = [];
    _selectedProperty = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}