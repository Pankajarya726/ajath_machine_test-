import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pankaj_ajath_maching_test/ui/assets_screen.dart';
Dio dio = Dio();
void main() {
  dio.interceptors.add(LogInterceptor(
    responseBody: true

  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const AssetsScreen(),
    );
  }
}

