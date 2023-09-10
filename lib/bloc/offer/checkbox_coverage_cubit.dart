import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkbox_coverage_state.dart';

class CheckboxCoverageCubit extends Cubit<CheckboxCoverageState> {
  CheckboxCoverageCubit() : super(CheckboxCoverageState([]));

  void addChecked(String id) {
    List<String> ids = state.checkboxIds;
    ids.add(id);
    emit(state.copyWith(ids: ids));
  }

  void removeChecked(String id) {
    List<String> ids = state.checkboxIds;
    ids.remove(id);
    emit(state.copyWith(ids: ids));
  }
}
