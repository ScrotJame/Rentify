import 'package:bloc/bloc.dart';
import '../../http/API.dart';
import '../../model/propertities.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final API api;

  DetailCubit(this.api) : super(DetailState(isLoading: false));

  Future<void> fetchPropertyDetail(int id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final property = await api.getProperty(id);
      print('Property data: $property');
      emit(state.copyWith(property: property, isLoading: false));
    } catch (e, stackTrace) {
      print('Error fetching property: $e');
      print('Stack trace: $stackTrace');
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}