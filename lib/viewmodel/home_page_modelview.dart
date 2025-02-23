import 'package:flutter/material.dart';
import 'package:rentify/bean/property.dart';
import 'package:rentify/http/API.dart'; // Giả sử bạn có class API ở đây

class PropertyViewModel extends ChangeNotifier {
  // Không cần _repository nữa
  // final PropertyViewModel _repository = PropertyViewModel();
  List<DetailProperty> _properties = [];
  List<AllProperty> _allproperties = [];
  bool _isLoading = false;
  String? _errorMessage;
  DetailProperty? _selectedProperty;

  List<DetailProperty> get properties => _properties;
  List<AllProperty> get allproperties => _allproperties;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  DetailProperty? get selectedProperty => _selectedProperty;

  Future<void> fetchProperties() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Cập nhật UI trước khi bắt đầu fetch

    try {
      // Gọi trực tiếp API.fetchProperties()
      _properties = await API
          .fetchProperties(); // Giả sử API.fetchProperties() trả về List<DetailProperty>
    } catch (e) {
      // Xử lý lỗi cụ thể hơn nếu có thể
      _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
      // Ví dụ:
      // if (e is TimeoutException) {
      //   _errorMessage = "Kết nối quá thời gian";
      // } else if (e is SocketException) {
      //   _errorMessage = "Lỗi kết nối mạng";
      // } else {
      //   _errorMessage = "Đã xảy ra lỗi không xác định";
      // }
    } finally {
      _isLoading = false;
      notifyListeners(); // Cập nhật UI sau khi fetch xong (thành công hoặc thất bại)
    }
  }
  Future<void> fetchAllProperty() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _allproperties = await API
          .fetchAllProperty();
    } catch (e) {
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
      _allproperties = await API
          .fetchAllProperty();
    } catch (e) {
      // Xử lý lỗi cụ thể hơn nếu có thể
      _errorMessage = "Đã xảy ra lỗi: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}