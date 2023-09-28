import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cores/constants/color.dart';
import '../cores/navigator/app_navigation_observer.dart';
import '../cores/navigator/app_router.dart';
import '../cores/navigator/router_generator.dart';
import 'locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // static final ToggleDarkModeBloc _toggleDarkModeBloc =
  //     getIt<ToggleDarkModeBloc>();
  static final AppNavObserver _appNavObserver = getIt<AppNavObserver>();

  @override
  Widget build(BuildContext context) {

      return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return  MaterialApp(
          title: 'Recon App',
          // themeMode: _toggleDarkModeBloc.themeMode,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: AppRouter.instance.navigatorKey,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [_appNavObserver],
        );
      },
    );

    // return ScreenUtilInit(
    //   designSize: const Size(375, 812),
    //   builder: (context, Widget? child) {
    //     return BlocBuilder<ToggleDarkModeBloc, ToggleDarkModeState>(
    //       bloc: _toggleDarkModeBloc,
    //       builder: (context, state) {
    //         return MaterialApp(
    //           title: 'Recon App',
    //           themeMode: _toggleDarkModeBloc.themeMode,
    //           theme: ThemeClass.lightTheme,
    //           darkTheme: ThemeClass.darkTheme,
    //           initialRoute: "/",
    //           onGenerateRoute: RouteGenerator.generateRoute,
    //           navigatorKey: AppRouter.instance.navigatorKey,
    //           debugShowCheckedModeBanner: false,
    //           navigatorObservers: [_appNavObserver],
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
