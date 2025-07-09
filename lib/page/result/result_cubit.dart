import 'package:flutter_bloc/flutter_bloc.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());
}
