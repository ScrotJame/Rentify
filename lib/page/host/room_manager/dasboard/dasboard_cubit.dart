import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dasboard_state.dart';

class DasboardCubit extends Cubit<DasboardState> {
  DasboardCubit() : super(DasboardInitial());
}
