import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_event.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_state.dart';
import 'package:rlink_test/features/service_providers/model/service_provider.dart';
import 'package:rlink_test/features/service_providers/model/service_provider_details.dart';
import 'package:rlink_test/src/network_services/end_points.dart';
import 'dart:developer' as dev;
class ServiceProviderBloc extends Bloc<ServiceProviderEvent, ServiceProviderState> {

  int currentPage = 1; // Track the current page of data
  bool hasReachedMax = false; // Flag to indicate if all data has been fetched

  ServiceProviderBloc() : super(ServiceProviderInitial()) {
    on<FetchServiceProviders>(_onFetchServiceProviders);
    on<FetchServiceProviderDetailsEvent>(_onFetchServiceProviderDetails);
  }

  Future<void> _onFetchServiceProviders(
      FetchServiceProviders event, Emitter<ServiceProviderState> emit) async {
    if (state is ServiceProviderLoaded && hasReachedMax) return; // Do nothing if all data is already fetched

    try {
      if (state is ServiceProviderInitial) {
        final response = await _fetchServiceProviders(event.page);
        emit(ServiceProviderLoaded(
          serviceProviders: response.serviceProviders,
          hasReachedMax: response.pagination.nextPageUrl == null,
        ));
      } else if (state is ServiceProviderLoaded) {
        // Fetch the rest of the pages and append to the existing list
        final currentState = state as ServiceProviderLoaded;
        final response = await _fetchServiceProviders(event.page);
        emit(response.serviceProviders.isEmpty
            ? currentState.copyWith(hasReachedMax: true) //if there is no more data then we reached the end
            : ServiceProviderLoaded(
          serviceProviders: currentState.serviceProviders + response.serviceProviders,
          hasReachedMax: response.pagination.nextPageUrl == null,
        ));
      }
      currentPage++;
    } catch (error) {
      emit(ServiceProviderError(error: error.toString()));
    }
  }

  Future<ServiceProviderResponse> _fetchServiceProviders(int page) async {
    final response = await Dio().request(

      getServiceProvidersPath(page: page),
      options: Options(
        method: 'GET',
        headers: {'Authorization': 'Bearer $token'},
      ),

    );

    return ServiceProviderResponse.fromJson(response.data);
  }
  ServiceProviderDetailsModel? serviceProviderDetailsModel;
  FutureOr<void> _onFetchServiceProviderDetails(FetchServiceProviderDetailsEvent event, Emitter<ServiceProviderState> emit)async {
  emit(state.copyWith(isLoading: true));
    try{
      final response = await Dio().request(

        getServiceProviderDetailsPath(id: event.id),
        options: Options(
          method: 'GET',
          headers: {'Authorization': 'Bearer $token'},
        ),

      );
      if(response.statusCode==200){
        serviceProviderDetailsModel = serviceProviderDetailsModelFromJson(response.data);
        print("loaded data successfully");
        emit(ServiceProviderDetailsLoaded());
      }else{
        emit(ServiceProviderDetailsError(error: response.statusMessage.toString()));
      }
    } catch(error){
      if (error is DioError) {
        print('DioError: ${error.response?.statusCode}');
        print('Response data: ${error.response?.data}');
      } else {
        dev.log(error.toString());
      }
      emit(ServiceProviderDetailsError(error: error.toString()));
    }
  emit(state.copyWith(isLoading: false));
  }
}
