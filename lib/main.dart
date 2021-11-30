import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plant_app/provider/myprovider.dart';
import 'package:plant_app/screens/checkout.dart';
import 'package:plant_app/screens/detail_screen.dart';
import 'package:plant_app/screens/homepage.dart';
import 'package:plant_app/screens/login.dart';
import 'package:plant_app/screens/profile_screen.dart';
import 'package:plant_app/screens/signup.dart';
import 'package:plant_app/screens/skip_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (ctx) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            actionTextColor: Colors.white,
            backgroundColor: Colors.lightGreen,
          ),
          primaryColor: Colors.lightGreen,
          accentColor: Color(0xff04d4ee),
        ),
        /*   home: StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context, snapshot) {
             if (snapshot.hasData) {
               return HomePage();
             } else {
               return Login();
             }
           },
         ),*/
        home: HomePage(),
      ),
    );
  }
}
