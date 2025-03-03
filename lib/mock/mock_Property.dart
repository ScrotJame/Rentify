// import 'package:rentify/model/login.dart';
//
// import '../http/API.dart';
// import '../http/log/log.dart';
// import '../model/amenities.dart';
// import '../model/pivot.dart';
// import '../model/propertities.dart';
// import '../model/user.dart';
// import '../model/images.dart';
// import '../model/amenities.dart';
// import '../http/API.dart';
// class API_implements implements API {
//   late Log log;
//
//   @override
//   Future<void> addTransaction(DetailProperty transaction) {
//     // TODO: implement addTransaction
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<bool> checkLogin(Login login) {
//     // TODO: implement checkLogin
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> deleteTransaction(String dateTime) {
//     // TODO: implement deleteTransaction
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> editTransaction(DetailProperty transaction) {
//     // TODO: implement editTransaction
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<List<AllProperty>> getAllProperty() {
//     // TODO: implement getAllProperty
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<List<DetailProperty>> getPropertys(int userId) {
//     final mockData = [
//       DetailProperty(
//         id: 1,
//         title: "Nhà trọ giá rẻ TP.HCM",
//         description: "Phòng trọ sạch sẽ, wifi, gần trường học",
//         location: "Quận 7, TP.HCM",
//         price: "2.5 triệu",
//         bedrooms: 1,
//         bathrooms: 1,
//         area: 20,
//         typeRestroom: "Riêng",
//         propertyType: "Nhà trọ",
//         status: "Còn trống",
//         userId: userId,
//         user: User(id: userId, name: "Nguyen Van A",avatar: '', bio: ''),
//         amenities: [
//           Amenity(
//             idAmenities: 1,
//             nameAmenities: "Wifi",
//             iconAmenities: "wifi_icon.png",
//             pivot: Pivot(propertyId: 1, amenityId: 1),
//           ),
//           Amenity(
//             idAmenities: 2,
//             nameAmenities: "Điều hòa",
//             iconAmenities: "ac_icon.png",
//             pivot: Pivot(propertyId: 1, amenityId: 2),
//           ),
//         ],
//         image: [Image(propertyId: 2, imageUrl: "http://example.com/apartment1.jpg")],
//       ),
//       DetailProperty(
//         id: 2,
//         title: "Chung cư cao cấp Đà Nẵng",
//         description: "Căn hộ sang trọng, hồ bơi, thang máy",
//         location: "Hải Châu, Đà Nẵng",
//         price: "8 triệu",
//         bedrooms: 2,
//         bathrooms: 2,
//         area: 50,
//         typeRestroom: "Riêng",
//         propertyType: "Chung cư",
//         status: "Còn trống",
//         userId: userId,
//         user: User(id: userId, name: "Tran Thi B",  avatar: '', bio: ''),
//         amenities: [
//           Amenity(
//             idAmenities: 1,
//             nameAmenities: "Wifi",
//             iconAmenities: "wifi_icon.png",
//             pivot: Pivot(propertyId: 1, amenityId: 1),
//           ),
//           Amenity(
//             idAmenities: 2,
//             nameAmenities: "Điều hòa",
//             iconAmenities: "ac_icon.png",
//             pivot: Pivot(propertyId: 1, amenityId: 2),
//           ),
//         ],
//         image: [Image(propertyId: 2, imageUrl: "http://example.com/apartment1.jpg")],
//       ),
//     ];
//     log.i('API', 'Mock getPropertys: $mockData');
//     return mockData;
//   }
//
//   @override
//   Future<List<DetailProperty>> searchProperties(String keyword) {
//     // TODO: implement searchProperties
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<DetailProperty> getProperty(int userId) {
//     // TODO: implement getProperty
//     throw UnimplementedError();
//   }
//
//
// }
//
//
//
