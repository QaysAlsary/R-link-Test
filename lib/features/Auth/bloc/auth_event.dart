part of 'auth_bloc.dart';

 class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}
class LoginWithPhoneEvent extends AuthEvent{}
class LoginWithEmailEvent extends AuthEvent{}
class RegisterEvent extends AuthEvent{}
