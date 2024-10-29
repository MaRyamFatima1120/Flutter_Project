import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_sharedpreference/src/routes/go_route.dart';
import 'package:todo_app_with_sharedpreference/src/themes/theme.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =GlobalKey<ScaffoldMessengerState>();
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: appTheme(
        context,
      ),
      routerDelegate: MyAppRouter.router.routerDelegate,
      routeInformationParser: MyAppRouter.router.routeInformationParser,
      routeInformationProvider: MyAppRouter.router.routeInformationProvider,
    );
  }
}
