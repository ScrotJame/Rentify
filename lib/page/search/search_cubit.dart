import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/propertities.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final API api;
  SearchCubit(this.api) : super(SearchState(properties: [], isLoading: false));

  Future<void> searchProperties() async {
    if (state.query == null || state.query!.isEmpty) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa tìm kiếm', currentPage: 'search'));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null, currentPage: 'result'));
    try {
      final properties = await api.searchProperties(state.query!);
      emit(state.copyWith(properties: properties, isLoading: false, currentPage: 'result'));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false, currentPage: 'result'));
    }
  }

  void navigateToSearch() {
    emit(state.copyWith(currentPage: 'search'));
  }

  void navigateToResult() {
    if (state.query != null && state.query!.isEmpty) {
      emit(state.copyWith(error: 'Vui lòng nhập từ khóa tìm kiếm', currentPage: 'search'));
    } else {
      searchProperties();
    }
  }

  void updateQuery(String query) {
    emit(state.copyWith(query: query.trim(), currentPage: 'search'));
  }
}
