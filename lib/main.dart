import 'package:agrimatics/providers/language_provider.dart';
import 'package:agrimatics/providers/post_provider.dart';
import 'package:agrimatics/providers/crop_info_provider.dart';
import 'package:agrimatics/providers/google_sign_in.dart';
import 'package:agrimatics/providers/store_provider.dart';
import 'package:agrimatics/screens/authentication/home_screen_controller.dart';
import 'package:agrimatics/screens/authentication/login_screen.dart';
import 'package:agrimatics/screens/rent_screen.dart';
import 'package:agrimatics/screens/community/community_screen.dart';
import 'package:agrimatics/screens/crop_information/crop_information.dart';
import 'package:agrimatics/screens/crop_recommendation_screen.dart';
import 'package:agrimatics/screens/disease_detection.dart';
import 'package:agrimatics/screens/home_screen.dart';
import 'package:agrimatics/screens/weather_screen.dart';
import 'package:agrimatics/screen_routes.dart';
import 'package:agrimatics/screens/store/store_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ChangeNotifierProvider(create: (_) => CropInfoProvider()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => StoreProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agriculture and Informatics System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x2caa5e)),
        useMaterial3: true,
      ),
      home: HomeController(),
      initialRoute: homeController,
      routes: {
        homeController : (context) => const HomeController(),
        loginScreen: (context) => const LoginScreen(),
        homeScreen: (context) => const HomeScreen(),
        storeScreen: (context) => const StoreScreen(),
        diseaseDetection: (context) => const DiseaseDetection(),
        cropRecommendation: (context) => const CropRecommendationScreen(),
        weatherDataScreen: (context) => const WeatherScreen(),
        cropInformation: (context) => const CropInformation(),
        communityScreen: (context) => const CommunityScreen(),
        rentScreen: (context) => const RentScreen(),
      },
    );
  }
}
