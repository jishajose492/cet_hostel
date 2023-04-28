import 'package:cet_hostel/providers/user_provider.dart';
import 'package:cet_hostel/responsive/mobile_screen_layout.dart';
import 'package:cet_hostel/responsive/responsive_layout_screen.dart';
import 'package:cet_hostel/responsive/web_screen_layout.dart';
import 'package:cet_hostel/screens/hostel_staff/home.dart';
import 'package:cet_hostel/screens/login_screen.dart';
import 'package:cet_hostel/screens/signup_screen.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAAy368IIVuTTz0kOE335bybEofSF8Du1E',
        appId: '1:220237089469:web:372032580d1488227585d4',
        messagingSenderId: '220237089469',
        projectId: "cethostel-f837e",
        storageBucket: "cethostel-f837e.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cet_Hostel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print('snapshot.connectionState == ConnectionState.active');
              if (snapshot.hasData) {
                print('mobile');
                return HomePageforstaff();
                // return const ResponsiveLayout(
                //   MobileScreenLayout: MobileScreenLayout(),
                //   WebScreenLayout: WebScreenLayout(),
                // );
              } else if (snapshot.hasError) {
                print('error');
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
