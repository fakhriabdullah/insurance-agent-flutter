import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:insurance_agent_flutter/model/offer/offer_model.dart';
import 'package:insurance_agent_flutter/repositories/offer_repository.dart';
import 'package:meta/meta.dart';

part 'get_offer_detail_state.dart';

class GetOfferDetailCubit extends Cubit<GetOfferDetailState> {
  final OfferRepository _repository = OfferRepository();
  GetOfferDetailCubit() : super(GetOfferInitial());

  void getOfferDetail(int id) async {
    try {
      emit(GetOfferLoading());
      var resp = await _repository.getOfferDetail(id);
      if (resp?.status ?? false) {
        emit(GetOfferLoaded(resp!.data!));
      } else {
        emit(GetOfferError());
      }
    } catch (e) {
      log(e.toString());
      emit(GetOfferError());
    }
  }
}
