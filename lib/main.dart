import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remainder_jash/screens/signup.dart';
import 'package:remainder_jash/screens/startpage.dart';
import 'package:remainder_jash/screens/theme.dart';
import 'package:remainder_jash/screens/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Remainder App',
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
      darkTheme: Themes.light,
      themeMode: ThemeService().theme,
      home: StartPage(),
    );
  }
}
