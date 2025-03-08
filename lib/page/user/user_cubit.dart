import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final API  api;
  UserCubit(this.api) : super(UserState());
  Future<void> fecthUser() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await api.getUser();
      emit(state.copyWith(userCb: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
