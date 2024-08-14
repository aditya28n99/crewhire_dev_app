import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:crewhire_dev_app/login/ChooseProfileScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyAZ9cJNJH4F7s2NIb4SVymPsTT1VJ1XK7s",
    appId: "1:700680226708:android:243c533d02531c1f02f181",
    messagingSenderId: "700680226708",
    projectId: "crewhireapp",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChooseProfileScreen(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/choose_profile', page: () => const ChooseProfileScreen()),
      ],
    );
  }
}
