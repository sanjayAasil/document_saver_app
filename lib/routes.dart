import 'package:doc_saver_app/view/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String mainScreen = '/';

  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
