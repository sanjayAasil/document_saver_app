import 'package:doc_saver_app/common/app_theme_data.dart';
import 'package:doc_saver_app/provider/home_provider.dart';
import 'package:doc_saver_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
