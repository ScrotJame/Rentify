import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/favorite.dart';
import '../../http/API.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final API api;
  List<Favorite> _favorites = [];
  FavoriteCubit(this.api) : super(FavoriteInitial()) {
    loadFavorites();
  }

  Future<void> toggleFavorite(int propertyId) async {
    try {
      // Kiểm tra xem property đã là yêu thích chưa
      bool isFavorite = _favorites
          .expand((favorite) => favorite.data)
          .any((item) => item.id == propertyId);

      print('ToggleFavorite: Property $propertyId isFavorite: $isFavorite'); // Debug

      Map<String, dynamic> response;
      if (isFavorite) {
        // Nếu đã là yêu thích, xóa khỏi danh sách
        response = await api.deleteFavorite(propertyId);
        print('Delete response: ${response.toString()}'); // Debug

        // Cập nhật danh sách local (không gọi API lại)
        _favorites = _favorites.map((favorite) {
          return Favorite(
            message: favorite.message,
            data: favorite.data.where((item) => item.id != propertyId).toList(),
          );
        }).where((favorite) => favorite.data.isNotEmpty).toList();

        emit(FavoriteSuccess(
          isFavorite: false,
          message: response['message'] ?? 'Đã xóa khỏi danh sách yêu thích',
        ));
      } else {
        // Nếu chưa có trong yêu thích, thêm vào danh sách
        response = await api.addFavorite(propertyId);
        print('Add response: ${response.toString()}'); // Debug

        // Lấy thông tin đầy đủ của property vừa thêm vào yêu thích
        // final newFavoriteProperty = await api.getProperty(propertyId);
        //
        // // Thêm vào danh sách local
        // if (newFavoriteProperty != null) {
        //   if (_favorites.isEmpty) {
        //     _favorites = [Favorite(message: "Added", data: [newFavoriteProperty])];
        //   } else {
        //     // Thêm vào favorite đầu tiên hoặc tạo mới nếu cần
        //     if (_favorites[0].data.isEmpty) {
        //       _favorites[0] = Favorite(message: _favorites[0].message, data: [newFavoriteProperty]);
        //     } else {
        //       _favorites[0].data.add(newFavoriteProperty);
        //     }
        //   }
        // }

        emit(FavoriteSuccess(
          isFavorite: true,
          message: response['message'] ?? 'Đã thêm vào danh sách yêu thích',
        ));
      }

      // Phát ra trạng thái mới với danh sách đã cập nhật
      emit(FavoriteListLoaded(
        favorites: _favorites,
        message: _favorites.isNotEmpty ? 'Danh sách yêu thích đã cập nhật' : 'Danh sách trống',
      ));
    } catch (e) {
      print('Error in toggleFavorite: $e'); // Debug
      emit(FavoriteError('Lỗi: $e'));
    }
  }

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    try {
      _favorites = await api.getFavorites();
      emit(FavoriteListLoaded(
        favorites: _favorites,
        message: _favorites.isNotEmpty ? 'Đã tải danh sách yêu thích' : 'Danh sách trống',
      ));
    } catch (e) {
      emit(FavoriteError('Lỗi khi tải danh sách: $e'));
    }
  }
}