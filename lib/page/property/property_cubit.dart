import 'package:flutter_bloc/flutter_bloc.dart';
import '../../http/API.dart';
import '../../model/propertities.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final API api;

  PropertyCubit(this.api) : super(PropertyState(properties: [], propertiesByOwner: [], isLoading: false));

  Future<void> fetchAllProperties() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final properties = await api.getAllProperty();
      emit(state.copyWith(properties: properties, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void setSelectIDProperty(int id) {
    // emit(state.copyWith(selectedIDProperty: id));
  }
  Future<void> fetchAllPropertiesByOwner() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final properties = await api.getAllPropertyByOwner();
      emit(state.copyWith(propertiesByOwner: properties, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
