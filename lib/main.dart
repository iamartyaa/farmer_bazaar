import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pirate_hunt/providers/cart.dart';
import 'package:pirate_hunt/providers/order.dart';
import 'package:pirate_hunt/screens/cart/cart_screen.dart';
import 'package:pirate_hunt/screens/home/home_screen.dart';
import 'package:pirate_hunt/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pirate_hunt/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'screens/drop_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          create: ((context) => Cart()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Orders()),
        ),
      ],
      // create: (context) => Cart(),
      child: MaterialApp(
        title: 'Bazaar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          primarySwatch: Colors.blue,
          fontFamily: "Gordita",
          appBarTheme: const AppBarTheme(
              // backgroundColor: Colors.transparent,
              // elevation: 0,
              ),
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const DropScreen();
            }

            if (userSnapshot.hasData) {
              return const SecondHomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          // HomeScreen.routeName: (context) => const HomeScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          SecondHomeScreen.routeName: (context) => const SecondHomeScreen(),
          DropScreen.routeName: (context) => const DropScreen(),
        },
      ),
    );
  }
}
