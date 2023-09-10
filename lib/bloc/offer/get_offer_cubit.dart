import 'package:bloc/bloc.dart';
import 'package:insurance_agent_flutter/model/offer/offer_model.dart';
import 'package:insurance_agent_flutter/repositories/offer_repository.dart';
import 'package:meta/meta.dart';

part 'get_offer_state.dart';

class GetOfferCubit extends Cubit<GetOfferState> {
  int _page = 1;
  int _totalPage = 1;
  List<OfferModel> data = [];
  final OfferRepository _repository = OfferRepository();
  GetOfferCubit() : super(GetOfferInitial()) {
    getOffer();
  }

  void getOffer() async {
    try {
      _page = 1;
      _totalPage = 1;
      emit(GetOfferLoadingFirst());
      var resp = await _repository.getOffer(_page);
      if (resp?.status ?? false) {
        data = resp?.data ?? [];
        emit(GetOfferLoaded(data));
        _totalPage = resp?.totalPage ?? 1;
      } else {
        emit(GetOfferLoaded(const []));
      }
    } catch (e) {
      emit(GetOfferLoaded(const []));
    }
  }

  void getOfferNext() async {
    try {
      if (_page == _totalPage) {
        return;
      }
      _page++;
      // emit(GetOfferLoadingNext());
      var resp = await _repository.getOffer(_page);
      if (resp?.status ?? false) {
        _totalPage = resp?.totalPage ?? 1;
        data.addAll(resp?.data ?? []);
        
        emit(GetOfferLoaded(data));
        
      } else {
        emit(GetOfferLoaded(const []));
      }
    } catch (e) {
      emit(GetOfferLoaded(const []));
    }
  }
}
