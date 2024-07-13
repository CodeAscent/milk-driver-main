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
                children: [
                  const Spacer(),
                  SizedBox(
                    // height: size.height / 2.25,
                    child: Center(
                      child: Image(
                        image: const AssetImage('asset/images/logo.jpg'),
                        width: size.width / 2,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Select Language',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorUtils.kcWhite
                            : ColorUtils.kcBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 51,
                  ),
                  if (appState.setting.value.languages != null)
                    ...value.languages!.asMap().entries.map((e) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          selectLanguageButton(
                            width: size.width,
                            onPress: () async {
                              print(e.value.languageName);
                              appState.languageItem = e.value;
                              final get = GetStorage();
                              get.write("language", e.value.languageCode);
                              appState.currentLanguageCode.value =
                                  e.value.languageCode!;
                              //  var auth  = ApiHandler();
                              appState.languageKeys = await getKeysLists(
                                  appState.currentLanguageCode.value);
                              // EasyLocalization.of(context)?.setLocale(
                              //     Locale(
                              //         languageItem.languageCode!,
                              //         languageItem.languageCode == "ar"
                              //             ? 'AE'
                              //             : 'US'));
                              // TODO : Need to add country code in language object in setting api
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.isFromProfile ?
                              //   HomeScreen()
                              //  :const LoginScreen()),(route) => false);
                              UtilsHelper.loadLocalization(
                                  e.value.languageCode!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            prefixPath: 'asset/icons/icon_arrow.svg',
                            title: e.value.languageCode == "ar"
                                ? 'العربية'
                                : e.value.languageName!.toUpperCase(),
                            // TODO : Need to make dynamic data
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: ColorUtils.kcWhite,
                                    ),
                            color: e.key % 2 == 0
                                ? ColorUtils.kcPrimary
                                : ColorUtils.kcSecondary,
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                        ],
                      );
                    }),
                  const Spacer(),
                ],
              ),
            );
          }),
    );
  }
}
