part of 'auth_bloc.dart';

 class AuthState extends Equatable {
  final bool isLoading;
  const AuthState({
this.isLoading = false,
});
  @override
  List<Object> get props => [
    isLoading,
  ];

  AuthState copyWith({
    bool? isLoading,
  }) =>
      AuthState(
        isLoading: isLoading?? this.isLoading,
      );
}
class SuccessState extends AuthState {}
class ErrorState extends AuthState{}
class SelectImageState extends AuthState{}

