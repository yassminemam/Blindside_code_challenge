import 'dart:io';
import 'package:blindside_code_challenge/routes/app_routs.dart';
import 'package:blindside_code_challenge/view/all_videos/all_video_page.dart';
import 'package:blindside_code_challenge/view/auth/phone_auth/sign_in_otp_page.dart';
import 'package:blindside_code_challenge/view/auth/phone_auth/signin_page.dart';
import 'package:blindside_code_challenge/view_model/app_auth_provider.dart';
import 'package:blindside_code_challenge/view_model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:blindside_code_challenge/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: AppStrings.ios_apiKey,
            appId: AppStrings.ios_appId,
            messagingSenderId: AppStrings.ios_messagingSenderId,
            projectId: AppStrings.ios_projectId))
        .then((value) => runApp(const MyApp()));
  } else {
    await Firebase.initializeApp().then((value) => runApp(const MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blindside Challenge',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppAuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.sign_in_page,
          title: AppStrings.appTitle,
          routes: {
            AppRoutes.sign_in_phone_otp_page: (context) => SignInOTPPage(),
            AppRoutes.sign_in_page: (context) => SigninPage(),
            AppRoutes.all_videos_page: (context) => AllVideosPage(),
          },
        ));
  }
}
