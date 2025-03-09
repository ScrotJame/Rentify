import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/propertities.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final API api;
  SearchCubit(this.api) : super(SearchState(result: [], isLoading: false));

  Future<void> searchProperties(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa tìm kiếm', isLoading: false));
      return;
    }

    emit(state.copyWith(query: query, isLoading: true, error: null));
    try {
      final properties = await api.searchProperties(query);
      emit(state.copyWith(result: properties, query: query, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }


  void navigateToSearch() {
    emit(state.copyWith(currentPage: 'search'));
  }

  void navigateToResult(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa tìm kiếm', currentPage: 'search'));
    } else {
      searchProperties(query);
    }
  }

  void updateQuery(String query) {
    emit(state.copyWith(query: query.trim(), currentPage: 'search'));
  }
}
