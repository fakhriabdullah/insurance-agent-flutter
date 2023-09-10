part of 'get_offer_cubit.dart';

@immutable
sealed class GetOfferState {}

final class GetOfferInitial extends GetOfferState {}

final class GetOfferLoadingFirst extends GetOfferState {}

final class GetOfferLoadingNext extends GetOfferState {}

final class GetOfferLoaded extends GetOfferState {
  final List<OfferModel> offers;
  GetOfferLoaded(this.offers);

  GetOfferLoaded copyWith(List<OfferModel> offers2) {
    return GetOfferLoaded(offers2);
  }
}
