import 'package:flutter_bloc/flutter_bloc.dart';
import '../../http/API.dart';
import '../../model/propertities.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final API api;

  DetailCubit(this.api) : super(const DetailState(isLoading: false));

  Future<void> fetchPropertyDetail(int id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final property = await api.getProperty(id);
      emit(state.copyWith(property: property, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}