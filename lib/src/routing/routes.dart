import 'package:flutter/material.dart';
import 'package:rlink_test/features/Auth/presentaion/screens/login_screen.dart';
import 'package:rlink_test/features/Auth/presentaion/screens/register_screen.dart';
import 'package:rlink_test/features/service_providers/presentation/screens/service_provider_details_screen.dart';
import 'package:rlink_test/features/service_providers/presentation/screens/service_providers_screen.dart';

class Routes {
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String homeRoute = "/service_providers";
  static const String serviceProviderDetailsRoute = "/service_provider_details";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) =>  ServiceProvidersScreens());
      case Routes.serviceProviderDetailsRoute:
        return MaterialPageRoute(builder: (_)  {
          int id = (settings.arguments as Map<String, dynamic>)['id'];
          return ServiceProviderDetailScreen(id: id);
        });

      default:
        return undefinedroute();
    }
  }

  static Route<dynamic> undefinedroute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
                appBar: AppBar(
              title: const Text("no route found"),
            )));
  }
}
