import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/services/notification_services.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/theme.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyHelper().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
