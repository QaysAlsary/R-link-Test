import 'package:equatable/equatable.dart';

abstract class ServiceProviderEvent extends Equatable {
  const ServiceProviderEvent();

  @override
  List<Object> get props => [];
}

class FetchServiceProviders extends ServiceProviderEvent {
  final int page;

  const FetchServiceProviders({required this.page});

  @override
  List<Object> get props => [page];
}
class FetchServiceProviderDetailsEvent extends ServiceProviderEvent{
  final int id;
  const FetchServiceProviderDetailsEvent({required this.id});
  @override
  List<Object> get props => [id];
}
