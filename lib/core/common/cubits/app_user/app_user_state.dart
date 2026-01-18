part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserSignedOut extends AppUserState {}

final class AppUserSignedIn extends AppUserState {
  final User user;

  const AppUserSignedIn(this.user);
}
