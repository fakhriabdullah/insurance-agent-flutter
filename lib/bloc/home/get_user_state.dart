part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}

final class GetUserLoaded extends GetUserState {
  final UserModel user;

  GetUserLoaded(this.user);
}
