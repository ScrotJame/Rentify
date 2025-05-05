import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/propertities.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final API api;
  SearchCubit(this.api) : super(SearchState(result: [], isLoading: false));

  Future<void> searchProperties(String query, {int? tenant, int? rooms}) async {
    if (query.isEmpty && tenant == null && rooms == null) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa hoặc chọn bộ lọc', isLoading: false));
      return;
    }

    emit(state.copyWith(query: query, totalTenant: tenant, totalRooms: rooms, isLoading: true, error: null));
    try {
      final properties = await api.searchProperties(query,  tenant :tenant, totalRooms: rooms);
      if (properties.isEmpty) {
        emit(state.copyWith(
          result: [],
          query: query,
          totalTenant: tenant,
          totalRooms: rooms,
          isLoading: false,
          error: 'Không có căn hộ phù hợp',
        ));
      } else {
        emit(state.copyWith(
          result: properties,
          query: query,
          totalTenant: tenant,
          totalRooms: rooms,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }


  void navigateToSearch() {
    emit(state.copyWith(currentPage: 'search'));
  }

  void navigateToResult(String query, {int? Tenant, int? Rooms}) {
    if (query.isEmpty && Tenant == null && Rooms == null) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa hoặc chọn bộ lọc'));
    } else {
      searchProperties(query, tenant: Tenant, rooms: Rooms);
    }
  }

  void updateQuery(String query) {
    emit(state.copyWith(query: query.trim()));
  }
}
