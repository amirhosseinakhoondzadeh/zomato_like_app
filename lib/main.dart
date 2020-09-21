import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:zomato_like_app/dependency_injection/injection_container.dart'
    as di;
import 'package:zomato_like_app/ui/side_bar/side_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  services.SystemChrome.setPreferredOrientations([
    services.DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zomato Like App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SideBarScreen(),
    );
  }
}
