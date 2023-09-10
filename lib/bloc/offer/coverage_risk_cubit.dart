import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:insurance_agent_flutter/model/coveragerisk/coverage_risk_model.dart';
import 'package:insurance_agent_flutter/repositories/offer_repository.dart';
import 'package:meta/meta.dart';

part 'coverage_risk_state.dart';

class CoverageRiskCubit extends Cubit<CoverageRiskState> {
  OfferRepository repository = OfferRepository();
  CoverageRiskCubit() : super(CoverageRiskInitial()) {
    _getCoverageRisk();
  }

  void _getCoverageRisk() async {
    emit(CoverageRiskLoading());
    try {
      var resp = await repository.getCoverageRisk();
      if (resp?.status ?? false) {
        emit(CoverageRiskLoaded(resp?.data ?? []));
      } else {
        emit(CoverageRiskLoaded(const []));
      }
    } catch (e) {
      log(e.toString());
      emit(CoverageRiskLoaded(const []));
    }
  }
}
