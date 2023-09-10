part of 'add_offer_cubit.dart';

@immutable
abstract class AddOfferState {}

class AddOfferInitial extends AddOfferState {}

class AddOfferLoading extends AddOfferState {}

class AddOfferSuccess extends AddOfferState {
  final int id;
  AddOfferSuccess(this.id);
}

class AddOfferError extends AddOfferState {
  final String message;
  AddOfferError(this.message);
}
