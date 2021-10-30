import 'package:flutter/material.dart';
import 'package:election_exit_poll_07610567/pages/food/food_details_page.dart';
import 'package:election_exit_poll_07610567/pages/food/food_list_page.dart';
import 'package:election_exit_poll_07610567/pages/home/home_page.dart';
import 'package:election_exit_poll_07610567/pages/login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.prompt().fontFamily,
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 22.0,
            //fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      //home: LoginPage(),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        FoodListPage.routeName: (context) => const FoodListPage(),
        FoodDetailsPage.routeName: (context) => const FoodDetailsPage(),
      },
      initialRoute: LoginPage.routeName,
    );
  }
}
