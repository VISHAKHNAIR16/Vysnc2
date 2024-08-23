import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vysnc_app/screen/home_screen.dart';
import 'package:vysnc_app/screen/login_screen.dart';
import 'package:vysnc_app/screen/onboard.dart';

int? isviewed;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/'));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  MyApp get widget => super.widget;

  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    debugPrint("pasuing");
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("unpaused");
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: widget.initialRoute,
      routes: {
        '/': (context) => const OnBoard(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
