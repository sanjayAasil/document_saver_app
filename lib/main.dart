import 'package:doc_saver_app/common/app_theme_data.dart';
import 'package:doc_saver_app/provider/home_provider.dart';
import 'package:doc_saver_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = HomeProvider();

    return ChangeNotifierProvider(
      create: (_) => homeProvider,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemeData.themeData,
        onGenerateRoute: Routes.onGenerate,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
