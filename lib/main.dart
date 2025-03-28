import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partner/bottom_navigation_bar.dart';
import 'package:partner/map/map_screen.dart';
import 'package:partner/mock_data.dart';
import 'package:partner/views/home/collection_schedule_screen.dart';

void main() => runApp(
      DevicePreview(
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => BottomNavigationBars()),
          GetPage(name: '/schedule', page: () => CollectionScheduleScreen())
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNavigationBars(),
      ),
    );
  }
}
