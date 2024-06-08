// import 'dart:html';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyA0Ie80wZ2sgvGPUXLePZqPgIiH3EgSEy8",
            appId: "1:406653562727:android:ebbb8407b108e0e6bcc9c2",
            messagingSenderId: "406653562727",
            projectId: "emart-d06f9",
            storageBucket: "emart-d06f9.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // using get-material bcz we use get method in splash
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: darkFontGrey)),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
  }
}
