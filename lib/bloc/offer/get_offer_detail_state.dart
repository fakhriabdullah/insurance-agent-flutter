part of 'get_offer_detail_cubit.dart';

@immutable
sealed class GetOfferDetailState {}

final class GetOfferInitial extends GetOfferDetailState {}

final class GetOfferLoading extends GetOfferDetailState {}
final class GetOfferError extends GetOfferDetailState {}


final class GetOfferLoaded extends GetOfferDetailState {
  final OfferModel offers;
  GetOfferLoaded(this.offers);
}
