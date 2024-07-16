import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  String locationMessage = "";

  Future showLocationPermissionDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Information'),
          content: const Text(
              'We need your location information to navigate drivers to the exact delivery location even when app is closed or not in use.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getCurrentLocation();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get the current location.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showLocationPermissionDialog(navkey.currentState!.context);

      await initSettings().then((value) async {
        appState.setting.value = value;
        setState(() {});
      });
      await getKeysLists(appState.currentLanguageCode.value).then((value) {
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
    });

    // });
    super.initState();
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
