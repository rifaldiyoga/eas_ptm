import 'package:flutter/material.dart';
import 'package:shamo/pages/dosen/dosen_page.dart';
import 'package:shamo/pages/dosen/form_dosen.dart';
import 'package:shamo/pages/home/main_page.dart';
import 'package:shamo/pages/mahasiswa/form_mahasiswa.dart';
import 'package:shamo/pages/mahasiswa/mahasiswa_page.dart';
import 'package:shamo/pages/sign_in_page.dart';
import 'package:shamo/pages/sign_up_page.dart';
import 'package:shamo/pages/splash_page.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => SplashPage(),
      '/sign-in': (context) => SignInPage(),
      '/sign-up': (context) => SignUpPage(),
      '/home': (context) => MainPage(),
      '/mahasiswa': (context) => MahasiswaPage(),
      '/dosen': (context) => DosenPage(),
      '/mahasiswa_form': (context) => MahasiswaFormPage(),
      '/dosen_form': (context) => DosenFormPage(),
      // '/dosen': (context) => DosenPage(),
    });
  }
}
