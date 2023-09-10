part of 'checkbox_coverage_cubit.dart';

class CheckboxCoverageState {
  List<String> checkboxIds;
  CheckboxCoverageState(this.checkboxIds);
  CheckboxCoverageState copyWith({
    final List<String>? ids,
  }) {
    return CheckboxCoverageState(ids ?? checkboxIds);
  }
}
