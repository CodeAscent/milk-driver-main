import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:water/Utils/controller/auth_controller.dart';
import 'package:water/model/get_order_model.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/screen/splash.dart';
import 'package:water/utils/app_state.dart';
import 'package:water/utils/route.dart';
import 'package:water/utils/uttil_helper.dart';

import 'API/API_handler/lang.dart';
import 'Utils/color_utils.dart';

late AuthController authController;
GetStorage gets = GetStorage();

GlobalKey<NavigatorState> navkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  OneSignal.initialize("c2708dac-1973-44d7-9c86-d383e2a1c29e");
  //await firebaseMessaging();
  // var deviceTokenId = await FirebaseMessaging.instance.getToken();
  //print("tokenId $deviceTokenId");
  authController = Get.put(AuthController());

  try {
    final id = OneSignal.User.pushSubscription.id;
    if (id != null) {
      // setOnesignalUserId(id);
      await OneSignal.Notifications.requestPermission(true);
    }
    authController.getFromPrefs();
    gets.write('url', '1');
    if (gets.hasData('isDark')) {
      isDark.value = gets.read('isDark');
    }
  } catch (e) {
    print(e.toString());
  }
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String locationMessage = "";

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

  void showLocationPermissionDialog(BuildContext context) {
    showDialog(
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
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initSettings().then((value) {
        appState.setting.value = value;
        setState(() {});

        // Show the dialog after the page has loaded
        Future.delayed(Duration.zero, () {
          showLocationPermissionDialog(navkey.currentState!.context);
        });
      });
    });

    OneSignal.Notifications.addClickListener((result) async {
      result.preventDefault();

      /// notification.display() to display after preventing default
      result.notification.display();
      await notificationOpener(result);
    });

    super.initState();
    _getCurrentLocation();
  }

  Future<void> notificationOpener(OSNotificationClickEvent result,
      {String? id}) async {
    final order =
        json.decode(result.notification.rawPayload!['custom'].toString())['a']
            ['order_id'];
    //  final action = result.notification.rawPayload!['actionId'];
    // print(result.notification.additionalData!['order_id']);

    if (gets.read("token") != null) {
      if (gets.hasData('url')) {
        Future.delayed(const Duration(milliseconds: 5000), () {
          gets.remove('url');

          Navigator.of(navkey.currentState!.context)
              .pushNamed("/order_detail", arguments: [Datum(id: order), false]);
        });
      } else {
        Navigator.of(navkey.currentState!.context)
            .pushNamed("/order_detail", arguments: [Datum(id: order), false]);
      }
    }
    //  Navigator.push(navkey.currentState!.context,
    //  MaterialPageRoute(builder: (context) =>Loader(
    //   product: Product(id:int.parse(blog.toString())),
    //   action: action)));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isDark,
        builder: (context, value, child) {
          return ValueListenableBuilder(
              valueListenable: appState.currentLanguageCode,
              builder: (context, String languageCode, _) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Mamas Milk Farm Driver App',
                  themeMode: value ? ThemeMode.dark : ThemeMode.light,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  locale: Locale(languageCode),
                  theme: value == true
                      ? ThemeData(
                          primaryColor: const Color.fromRGBO(20, 33, 41, 1),
                          cardColor: const Color.fromRGBO(20, 33, 41, 1),
                          brightness: Brightness.dark,
                          iconButtonTheme: const IconButtonThemeData(
                              style: ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                      ColorUtils.kcPrimary))),
                          scaffoldBackgroundColor: ColorUtils.kcSecondary,
                        )
                      : ThemeData(
                          primaryColor: ColorUtils.kcPrimary,
                          cardColor: Colors.white,
                          brightness: Brightness.light,
                          iconButtonTheme: const IconButtonThemeData(
                              style: ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                      ColorUtils.kcPrimary))),
                          scaffoldBackgroundColor: Colors.white,
                        ),
                  navigatorKey: navkey,
                  builder: (context, child) {
                    child = Directionality(
                      textDirection:
                          UtilsHelper.rightHandLang.contains(languageCode)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      child: child as Widget,
                    );

                    return child;
                  },
                  home: const SplashScreen(),
                );
              });
        });
  }
}

// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// AndroidNotificationChannel? channel;

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling a background message ${message.messageId}');
// }

// Future<void> firebaseMessaging() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//    // 'This channel is used for important notifications.',
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   DarwinInitializationSettings initializationSettingsIOS =
//       const DarwinInitializationSettings(
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   flutterLocalNotificationsPlugin!.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: (payload) async {
//     print("onSelectNotification Called");
//     if (payload != null) {}
//   });

//   await flutterLocalNotificationsPlugin!
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel!);

//   await flutterLocalNotificationsPlugin!
//       .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//       ?.requestPermissions(alert: true, badge: true, sound: true);

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print("onMessage Called");

//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     Map<String, dynamic> payload = message.data;
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin!.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel!.id,
//               channel!.name,
//               //channel!.description,
//               icon: '@mipmap/ic_launcher',
//             ),
//             iOS: DarwinNotificationDetails(
//               subtitle: channel!.description,
//               presentSound: true,
//               presentAlert: true,
//             ),
//           ),
//           payload: jsonEncode(payload));
//     }
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//     print("onMessageOpenedApp Called ");
//     await Firebase.initializeApp();
//   });

//   FirebaseMessaging.instance.getInitialMessage().then((message) async {
//     print("getInitialMessage Called ");
//   });
// }

// Future onDidReceiveLocalNotification(
//   int? id,
//   String? title,
//   String? body,
//   String? payload,
// ) async {
//   print("iOS notification $title $body $payload");
// }


//8812988956
//123456789