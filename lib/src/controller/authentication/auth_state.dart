part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateAuthenticate extends AuthState {
  final String email;
  const AuthStateAuthenticate(this.email);

  @override
  List<Object> get props => [email];
}

class AuthStateUnauthenticate extends AuthState {
  final String error;
  const AuthStateUnauthenticate(this.error);

  @override
  List<Object> get props => [error];
}
