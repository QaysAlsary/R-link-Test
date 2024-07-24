import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_bloc.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_event.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_state.dart';
import 'package:rlink_test/src/di/services_locator.dart';
import 'package:rlink_test/src/routing/routes.dart';
import 'package:rlink_test/src/themes/app_colors.dart';
import 'package:rlink_test/src/utils/widget_extension.dart';


class ServiceProvidersScreens extends StatefulWidget {
  final ServiceProviderBloc bloc;
   ServiceProvidersScreens({super.key}):bloc=sl.get<ServiceProviderBloc>()..add(const FetchServiceProviders(page: 1));

  @override
  _ServiceProvidersScreensState createState() => _ServiceProvidersScreensState();
}

class _ServiceProvidersScreensState extends State<ServiceProvidersScreens> {
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
   // _serviceProviderBloc = BlocProvider.of<ServiceProviderBloc>(context);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      widget.bloc.add(
          FetchServiceProviders(page: widget.bloc.currentPage));
    }
  }
// Check if the user has scrolled to the bottom of the list
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Service Providers'),centerTitle: true,),
        body: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
          builder: (context, state) {
            if (state is ServiceProviderInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
            }  else if (state is ServiceProviderLoaded) {
              if (state.serviceProviders.isEmpty) {
                return const Center(child: Text('No data'));
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.serviceProviders.length
                    : state.serviceProviders.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.serviceProviders.length) {
                    // Show a loading indicator at the bottom of the list if more data is being fetched
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
                  }
                  final serviceProvider = state.serviceProviders[index];
                  return ListTile(
                    leading: Image.network(serviceProvider.image),
                    title: Text(serviceProvider.name),
                    subtitle: Text(serviceProvider.serviceTitle),
                  ).inkWell((){
                    Navigator.pushNamed(context, Routes.serviceProviderDetailsRoute,arguments:
                    {'id': serviceProvider.id,}
                    );

                   // Navigator.pushNamed(context, Routes.serviceProviderDetailsRoute);
                  });
                },
              );
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
//Dispose of the scroll controller to free up resources
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}



