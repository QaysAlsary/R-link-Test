import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rlink_test/src/di/app_initializer.dart';
import 'package:rlink_test/src/routing/routes.dart';
import 'package:rlink_test/src/themes/app_theme.dart';

void main() async{
  await AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (
            BuildContext context,
            Widget? child,
        ){
          return MaterialApp(
            title: 'Flutter Demo',
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.loginRoute,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
          );
        }
    );
  }
}

