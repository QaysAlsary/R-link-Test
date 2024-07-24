import 'package:equatable/equatable.dart';
import 'package:rlink_test/features/service_providers/model/service_provider.dart';

 class ServiceProviderState extends Equatable {
  final bool isLoading;
  const ServiceProviderState({
    this.isLoading=false,
});

  @override
  List<Object> get props => [isLoading];
  ServiceProviderState copyWith({
    bool? isLoading,
}){
    return ServiceProviderState(
      isLoading: isLoading?? this.isLoading,
    );
  }
}

class ServiceProviderInitial extends ServiceProviderState {}

class ServiceProviderLoading extends ServiceProviderState {}

class ServiceProviderLoaded extends ServiceProviderState {
  final List<ServiceProvider> serviceProviders;
  final bool hasReachedMax;

  const ServiceProviderLoaded({
    required this.serviceProviders,
    required this.hasReachedMax,
  });

  @override
  ServiceProviderLoaded copyWith({
    List<ServiceProvider>? serviceProviders,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return ServiceProviderLoaded(
      serviceProviders: serviceProviders ?? this.serviceProviders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [serviceProviders, hasReachedMax];
}

class ServiceProviderError extends ServiceProviderState {
  final String error;

  const ServiceProviderError({required this.error});

  @override
  List<Object> get props => [error];
}
class ServiceProviderDetailsLoading extends ServiceProviderState {}
class ServiceProviderDetailsLoaded extends ServiceProviderState{}
class ServiceProviderDetailsError extends ServiceProviderState{
  final String error;
  const ServiceProviderDetailsError({required this.error});
  @override
  List<Object> get props => [error];
}
