import 'package:bloc/bloc.dart';

import 'common/enum/drawer_item.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());

  void toggleTheme() {
    emit(state.copyWith(isLightTheme: !state.isLightTheme));
  }

  void changeTab(TabItem tabItem) {
    emit(state.copyWith(selected: tabItem));
  }
}
