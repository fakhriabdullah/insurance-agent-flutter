import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:insurance_agent_flutter/repositories/offer_repository.dart';
import 'package:insurance_agent_flutter/util/my_utils.dart';
import 'package:meta/meta.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  OfferRepository repository = OfferRepository();
  AddOfferCubit() : super(AddOfferInitial());

  void addOffer(Map<String, dynamic> params) async {
    emit(AddOfferLoading());
    try {
      var resp = await repository.addOffer(params);
      if (resp?.status ?? false) {
        emit(AddOfferSuccess(resp?.data ?? 0));
      } else {
        emit(AddOfferError(resp?.message ?? "Terjadi Kesalahan"));
      }
    } catch (e) {
      log(e.toString());
      emit(AddOfferError(MyUtils.handleErrorMessage(e)));
    }
  }
}
