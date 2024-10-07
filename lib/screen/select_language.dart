import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/model/setting_data.dart';
import 'package:water/screen/home_screen/home_screen.dart';
import 'package:water/utils/uttil_helper.dart';
import '../API/API_handler/lang.dart';
import '../Utils/color_utils.dart';
import '../utils/app_state.dart';
import '../utils/select_language_button.dart';
import 'login_screen/login.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key, this.isFromProfile = false})
      : super(key: key);
  final bool isFromProfile;

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.dependOnInheritedWidgetOfExactType();
    super.initState();
  }

  bool dark(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var lang = appState.currentLanguageCode.value;

    return Scaffold(
      body: ValueListenableBuilder<SettingData>(
          valueListenable: appState.setting,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 57),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // height: size.height / 2.25,
                    child: Center(
                      child: Image(
                        image: const AssetImage('asset/images/logo.jpg'),
                        width: size.width / 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Text(
                    'Welcome!',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: dark(context)
                            ? Colors.white
                            : ColorUtils.kcSecondary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final get = GetStorage();
                      get.write("language", 'en');
                      appState.currentLanguageCode.value = 'en';
                      setState(() {});

                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: ColorUtils.kcSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Let's Start",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            );
          }),
    );
  }
}

//    print(e.value.languageName);
//                               appState.languageItem = e.value;
//                               final get = GetStorage();
//                               get.write("language", e.value.languageCode);
//                               appState.currentLanguageCode.value =
//                                   e.value.languageCode!;
//                               //  var auth  = ApiHandler();
//                               appState.languageKeys = await getKeysLists(
//                                   appState.currentLanguageCode.value);
                            
//                               UtilsHelper.loadLocalization(
//                                   e.value.languageCode!);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const LoginScreen()));