import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/core/pages/app_pages.dart';
import 'package:scribe/data/db/notif_service.dart';
import 'package:scribe/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splash,
      routes: routes,
    );
  }
}

