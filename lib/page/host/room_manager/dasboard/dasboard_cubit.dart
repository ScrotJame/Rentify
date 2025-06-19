import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dasboard_state.dart';

class DasboardCubit extends Cubit<DasboardState> {
  DasboardCubit() : super(DasboardInitial());
}
