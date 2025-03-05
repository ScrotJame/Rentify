import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/amenities.dart';

part 'moreamenities_state.dart';

class MoreamenitiesCubit extends Cubit<MoreamenitiesState> {
  final API api;
  MoreamenitiesCubit(this.api) : super(MoreamenitiesState(amenities: []));
  Future<void> fetchAllPropertiesAmenities(int id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final amenities = await api.getAmenitiesProperty(id);
      emit(state.copyWith(amenities: amenities, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
