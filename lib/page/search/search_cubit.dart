import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/propertities.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final API api;
  SearchCubit(this.api) : super(SearchState(properties: [], isLoading: false));

  Future<void> searchProperties(String keyword) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final properties = await api.searchProperties(keyword);
      emit(state.copyWith(properties: properties, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
