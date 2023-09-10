part of 'coverage_risk_cubit.dart';

@immutable
abstract class CoverageRiskState {}

class CoverageRiskInitial extends CoverageRiskState {}

class CoverageRiskLoading extends CoverageRiskState {}

class CoverageRiskLoaded extends CoverageRiskState {
  final List<CoverageRiskModel> coverageRisks;
  CoverageRiskLoaded(this.coverageRisks);
}
