import 'package:flutter/material.dart';
import 'package:rlink_test/src/core/local_storage.dart';
import 'package:rlink_test/src/network_services/end_points.dart';

import 'services_locator.dart';

abstract class AppInitializer {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// dependency injection
    await ServicesLocator.setup();
    await LocalStorage.init();
    token = LocalStorage.token?? '';
  }
}
