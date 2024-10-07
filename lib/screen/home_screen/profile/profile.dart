import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/API/logout_api.dart';
import 'package:water/API/update_profile_api.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/icon_util.dart';
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/shadowedcontainer.dart';
import 'package:water/Utils/widgets/stackedscaffold.dart';
import 'package:water/main.dart';
import 'package:water/screen/home_screen/home_screen.dart';
import 'package:water/screen/login_screen/login.dart';
import 'package:water/utils/color_utils.dart';

import '../../../../API/API_handler/lang.dart';
import '../../../../model/language_item.dart';
import '../../../../utils/app_state.dart';
import '../../../../utils/select_language_button.dart';
import '../../../../utils/uttil_helper.dart';

import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/utils/widgets/arrowbutton.dart';
import 'package:water/utils/widgets/loader.dart';

import '../../../utils/anim_util.dart';

final HomeController homeController = Get.put(HomeController());

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // bool isDark = false;
  GetStorage gets = GetStorage();

  @override
  void initState() {
    super.initState();
    homeController.initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return StackedScaffold(
      stackedEntries: const [],
      tittle: UtilsHelper.getString(context, 'profile'),
      actionIcon: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: InkResponse(
          onTap: () {
            isDark.value = !isDark.value;
            gets.write('isDark', isDark.value);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: AnimateIcon(
              child: isDark.value
                  ? const Icon(Icons.sunny,
                      key: ValueKey(1), color: Colors.white)
                  : const Icon(Icons.nightlight, key: ValueKey(2)),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SpaceUtils.ks120.height(),
                SpaceUtils.ks30.height(),
                profileFirstTile(),
                SpaceUtils.ks20.height(),
                profileSecondTile(),
                SpaceUtils.ks20.height(),
                // profileThirdTile(),
                Obx(() => authController.updateProfile.isTrue
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26.0, vertical: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ArrowButton(
                            onTap: () => updateProfile(),
                            tittle: UtilsHelper.getString(context, "update"),
                            isUpdate: true,
                          ),
                        ),
                      )
                    : const SizedBox()),
                SpaceUtils.ks20.height(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //     ArrowButton(
                    //       onTap: () async => selectLanguageBottomSheet(context,
                    //               lang: appState.currentLanguageCode.value)
                    //           .then((value) {
                    //         setState(() {});
                    //       }),
                    //       tittle: UtilsHelper.getString(context, "select_language"),
                    //       isUpdate: true,
                    //     ),
                    ArrowButton(
                      onTap: () {
                        Get.dialog(Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  !UtilsHelper.rightHandLang.contains(
                                          appState.currentLanguageCode.value)
                                      ? "Are you sure you want to sign out ?"
                                      : "هل أنت متأكد أنك تريد الخروج ؟",
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: appButton(
                                          title: UtilsHelper.getString(
                                              context, "sign_out"),
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()),
                                                (route) => false);
                                            logOutService(context);
                                          }),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: appButton(
                                        color: Colors.white,
                                        textColor: ColorUtils.kcSecondary,
                                        title: UtilsHelper.getString(
                                            context, 'cancel'),
                                        onTap: () => Get.back(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      tittle: UtilsHelper.getString(context, "sign_out"),
                      isUpdate: false,
                      logOut: true,
                    ),
                  ],
                ),
                SpaceUtils.ks20.height(),
                SpaceUtils.ks20.height(),
              ],
            ),
          ),
          Obx(() => homeController.updateLoading.isTrue ||
                  authController.logOutLoading.isTrue
              ? const Loader()
              : const SizedBox())
        ],
      ),
    );
  }

  // Profile First Tile
  Widget profileFirstTile() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CommonShadowContainer(
            padding: const EdgeInsets.only(bottom: 27, top: 91 / 2 + 19),
            margin: const EdgeInsets.only(top: 91 / 2, left: 27, right: 27),
            child: Obx(() => Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      authController.name.value,
                      style: FontStyleUtilities.h4(fontWeight: FWT.semiBold),
                    ),
                    SpaceUtils.ks10.height(),
                    Text(
                      authController.email.value,
                      style: FontStyleUtilities.t2(),
                    )
                  ],
                )),
          ),
          Obx(() => authController.image.value.toString().isNotEmpty &&
                  authController.image.value.toString() != "null"
              ? CircleAvatar(
                  radius: 91 / 2,
                  backgroundImage: CachedNetworkImageProvider(
                      "${ApiUrls.waterUrl}app-assets/images/drivers/${authController.image.value}"),
                )
              : const CircleAvatar(
                  radius: 91 / 2,
                  backgroundColor: ColorUtils.kcLightTextColor,
                )),
        ],
      ),
    );
  }

  // Profile Second Tile
  Widget profileSecondTile() {
    return CommonShadowContainer(
      margin: const EdgeInsets.symmetric(horizontal: 27),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${UtilsHelper.getString(context, 'profile')} ${UtilsHelper.getString(context, 'setting')}",
                style: FontStyleUtilities.h5(fontWeight: FWT.bold),
              ),
              InkWell(
                  onTap: () {
                    authController.updateProfile.value = true;
                  },
                  child: SvgPicture.asset(
                    IconUtil.edit,
                    color: isDark.value ? Colors.white : null,
                  ))
            ],
          ),
          SpaceUtils.ks16.height(),
          Obx(() => editRow(
                parameter: UtilsHelper.getString(context, 'name'),
                value: authController.name.value.toString(),
                controller: homeController.nameController.value,
              )),
          Obx(
            () => editRow(
              parameter: UtilsHelper.getString(context, 'email_address'),
              value: authController.email.value.toString(),
              controller: homeController.emailController.value,
            ),
          ),
          Obx(
            () => editRow(
              parameter: UtilsHelper.getString(context, 'phone_number'),
              value: authController.phone.value.toString(),
              controller: homeController.phoneController.value,
            ),
          ),
        ],
      ),
    );
  }

//   import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';

  Future<dynamic> selectLanguageBottomSheet(context, {required lang}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            ClipRRect(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        UtilsHelper.getString(context, "select_language"),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              fontFamily:
                                  !UtilsHelper.rightHandLang.contains(lang)
                                      ? UtilsHelper.wr_default_font_family
                                      : UtilsHelper.the_sans_font_family,
                              color: isDark.value ? Colors.white : Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 51,
                      ),
                      if (appState.setting.value.languages != null)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: appState.setting.value.languages!.length,
                            itemBuilder: (context, index) {
                              LanguageItem languageItem =
                                  appState.setting.value.languages![index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  selectLanguageButton(
                                    onPress: () async {
                                      print(languageItem.languageName);
                                      appState.languageItem = languageItem;
                                      final get = GetStorage();
                                      homeController.detailLoading.value = true;
                                      setState(() {});
                                      get.write("language",
                                          languageItem.languageCode);
                                      appState.currentLanguageCode.value =
                                          languageItem.languageCode!;
                                      // showLoader();
                                      appState.languageKeys =
                                          await getKeysLists(appState
                                                  .currentLanguageCode.value)
                                              .then((value) {
                                        homeController.detailLoading.value =
                                            false;
                                        setState(() {});
                                        return value;
                                      });
                                      //  hideLoader();
                                      setState(() {});

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false);
                                    },
                                    prefixPath: 'asset/icons/icon_arrow.svg',
                                    title: languageItem.languageName!
                                        .toUpperCase(),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: UtilsHelper.rightHandLang
                                                  .contains(appState
                                                      .currentLanguageCode
                                                      .value)
                                              ? FontWeight.w400
                                              : FontWeight.bold,
                                          fontFamily: !UtilsHelper.rightHandLang
                                                  .contains(appState
                                                      .currentLanguageCode
                                                      .value)
                                              ? 'Sands'
                                              : UtilsHelper
                                                  .the_sans_font_family,
                                          color: ColorUtils.kcWhite,
                                        ),
                                    color: appState.currentLanguageCode.value ==
                                            languageItem.languageCode
                                        ? ColorUtils.kcPrimary
                                        : ColorUtils.kcSecondary,
                                  ),
                                  SizedBox(
                                    height: index ==
                                            appState.setting.value.languages!
                                                    .length -
                                                1
                                        ? 0
                                        : 20,
                                  ),
                                ],
                              );
                            }),
                      // selectLanguageButton(
                      //   onPress: () async {
                      //     print('arabic');
                      //     appState.currentLanguageCode.value = "ar";
                      //     appState.languageKeys = await settingRepo.getKeysLists(appState.currentLanguageCode.value);
                      //     setState(() {});
                      //     // EasyLocalization.of(context)
                      //     //     ?.setLocale(Locale('ar', 'AE'));
                      //     // Navigator.of(context).pushNamed(RoutePath.home_screen);
                      //   },
                      //   prefixPath: 'assets/icon_arrow.svg',
                      //   title: 'العربية',
                      //   textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      //         color: MyColor.textPrimaryLightColor,
                      //       ),
                      //   color: MyColor.commonColorSet1,
                      // ),
                      // SizedBox(
                      //   height: 11,
                      // ),
                      // selectLanguageButton(
                      //   onPress: () async {
                      //     print('english');
                      //     appState.currentLanguageCode.value = "en";
                      //     appState.languageKeys = await settingRepo.getKeysLists(appState.currentLanguageCode.value);
                      //     setState(() {
                      //       // context.setLocale(Locale('en', 'US'));
                      //       // EasyLocalization.of(context)
                      //       //     ?.setLocale(Locale('en', 'US'));
                      //     });
                      //     // Navigator.of(context).pushNamed(RoutePath.home_screen);
                      //   },
                      //   prefixPath: 'assets/icon_arrow.svg',
                      //   title: 'ENGLISH',
                      //   textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      //         color: MyColor.textPrimaryLightColor,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //   color: MyColor.darkYellow,
                      // ),
                      // SizedBox(
                      //   height: 27,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Obx(() => homeController.detailLoading.isTrue
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 30),
                          child: const Loader()))
                  : const SizedBox()),
            )
          ],
        );
      },
    );
  }

  // Profile Third Tile
  Widget profileThirdTile() {
    return CommonShadowContainer(
      margin: const EdgeInsets.symmetric(horizontal: 27),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Password',
                style: FontStyleUtilities.h5(fontWeight: FWT.bold),
              ),
              SvgPicture.asset(IconUtil.edit)
            ],
          ),
          SpaceUtils.ks16.height(),
          editRow(
            // isObs: true,
            parameter: 'Full Name',
            value: '*************',
            controller: null,
          ),
        ],
      ),
    );
  }

  // editRow()
  Widget editRow(
      {required String parameter, value, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(parameter,
                style: FontStyleUtilities.t1(
                    fontWeight: FWT.bold,
                    fontColor: ColorUtils.kcLightTextColor)),
          ),
          Text(
            '    :    ',
            style: FontStyleUtilities.t1(
                fontWeight: FWT.medium, fontColor: ColorUtils.kcLightTextColor),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => TextField(
                enabled: authController.updateProfile.value,
                controller: controller,
                // obscureText: isObs!,
                decoration: InputDecoration.collapsed(
                    hintText: parameter,
                    hintStyle: FontStyleUtilities.t1(
                        fontWeight: FWT.medium,
                        fontColor: ColorUtils.kcLightTextColor)),
                textAlign: TextAlign.left,
                style: FontStyleUtilities.t1(
                    fontWeight: FWT.medium,
                    fontColor: ColorUtils.kcLightTextColor))),
          ),
        ],
      ),
    );
  }

  appButton(
      {String? title, VoidCallback? onTap, Color? color, Color? textColor}) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? ColorUtils.kcSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.black.withOpacity(0.5),
          onTap: onTap,
          child: Center(
            child: Text(
              title!,
              style: TextStyle(color: textColor ?? Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
