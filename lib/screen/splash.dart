import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/screen/select_language.dart';
import 'package:water/utils/app_state.dart';

import '../API/API_handler/lang.dart';
import '../main.dart';
import 'home_screen/home_screen.dart';
import 'login_screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage gets = GetStorage();


  @override
  void initState() {
    getKeysLists(appState.currentLanguageCode.value).then((value) {
      print("This is value $value");
      appState.languageKeys = value;
      if (authController.token.value.toString() != "null" &&
          authController.token.value.isNotEmpty) {
        getOrderApi(url: "", orderHistory: false).whenComplete(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => !gets.hasData("language")
                    ? const SelectLanguage()
                    : const LoginScreen()),
            (route) => false);
      }
    });
    // });
    super.initState();

    // showLocationPermissionDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(237, 199, 240, 1),
                    Colors.white,
                    Colors.white,
                    Color.fromRGBO(237, 199, 240, 1)
                  ]))),
          Positioned(
              child: Center(
            child:
                Image.asset('asset/images/logo.jpg', width: 200, height: 200),
          ))
        ],
      ),
    );
  }
}
