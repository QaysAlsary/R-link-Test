import 'package:get_it/get_it.dart';
import 'package:rlink_test/features/Auth/bloc/auth_bloc.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_bloc.dart';
import 'package:rlink_test/src/core/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static setup() async {
    _injectBlocProviders();
  }

  static _injectBlocProviders() {
   sl.registerFactory(() => AuthBloc());
   sl.registerFactory(() => ServiceProviderBloc());
  }
}
