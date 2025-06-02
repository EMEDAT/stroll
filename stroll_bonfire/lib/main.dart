import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/stroll/presentation/cubit/stroll_cubit.dart';
import 'features/stroll/presentation/pages/stroll_bonfire_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const StrollBonfireApp());
}

class StrollBonfireApp extends StatelessWidget {
  const StrollBonfireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => StrollCubit()..initialize(),
          child: MaterialApp(
            title: 'Stroll Bonfire',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const StrollBonfirePage(),
          ),
        );
      },
    );
  }
}