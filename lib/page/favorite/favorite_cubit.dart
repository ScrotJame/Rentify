import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/favorite.dart';
import '../../http/API.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final API api;

  FavoriteCubit(this.api) : super(FavoriteInitial()) {
    loadFavorites();
  }

  Future<void> toggleFavorite(int propertyId) async {
    emit(FavoriteLoading());
    try {
      final response = await api.addFavorite(propertyId);
      if (response['success'] == true) {
        emit(FavoriteSuccess(
          isFavorite: true,
          message: response['message'] ?? 'Đã thêm vào danh sách yêu thích',
        ));
        await loadFavorites();
      } else {
        if (response['message']?.contains('đã có trong danh sách') ?? false) {
          final deleteResponse = await api.deleteFavorite(propertyId);
          if (deleteResponse['success'] == true) {
            emit(FavoriteSuccess(
              isFavorite: false,
              message: deleteResponse['message'] ?? 'Đã xóa khỏi danh sách yêu thích',
            ));
            await loadFavorites();
          } else {
            emit(FavoriteError(deleteResponse['message'] ?? 'Không thể xóa khỏi danh sách'));
          }
        } else {
          emit(FavoriteError(response['message'] ?? 'Lỗi không xác định khi thêm yêu thích'));
        }
      }
    } catch (e) {
      emit(FavoriteError('Lỗi hệ thống: $e'));
    }
  }

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await api.getFavorites();
      final favoriteItems = favorites
          .expand((favorite) => favorite.data)
          .map((item) => Favorite(
        message: '',
        data: [item],
      ))
          .toList();

      emit(FavoriteListLoaded(
        favorites: favoriteItems,
        message: favoriteItems.isNotEmpty ? 'Đã tải danh sách yêu thích' : 'Danh sách trống',
      ));
    } catch (e) {
      emit(FavoriteError('Lỗi khi tải danh sách: $e'));
    }
  }
}