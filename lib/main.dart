
import 'package:flutter/material.dart';
import 'package:login_20263/screens/cheking.dart';
import 'package:login_20263/screens/login.dart';
import 'package:login_20263/screens/principal.dart';
import 'package:login_20263/services/auth_service.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 163, 39, 240)),
        useMaterial3: true
      ),
      initialRoute: 'checking',
      routes: {
        'login': (_) => LoginPage(),
        'home' : (_) => PrincipalScr(),
        'checking' : (_) => CheckAuthScreen()
      },
    );
  }
}