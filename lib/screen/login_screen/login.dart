import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water/API/login_api.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/icon_util.dart';
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/arrowbutton.dart';
import 'package:water/Utils/widgets/shadowedcontainer.dart';
import 'package:water/main.dart';
import 'package:water/utils/app_state.dart';
import 'package:water/utils/color_utils.dart';
import 'package:water/utils/uttil_helper.dart';

import '../../utils/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void onTap() {
    isObs = !isObs;
    setState(() {});
  }

  void onSet(bool b) {
    isBusy = b;
    setState(() {});
  }

  bool isBusy = false;
  bool isObs = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtilsHelper.loadLocalization(appState.currentLanguageCode.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CommonShadowContainer(
                borderRadius: 25,
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 47),
                margin: const EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(UtilsHelper.getString(context, 'sign_in'),
                        style: FontStyleUtilities.h4(fontWeight: FWT.bold)),
                    SpaceUtils.ks40.height(),
                    SizedBox(
                      height: 55,
                      child: MyTextField(
                          icon: IconUtil.email,
                          hint: UtilsHelper.getString(context, 'phone_number'),
                          controller: authController.emailController.value,
                          length: 10),
                    ),
                    SpaceUtils.ks20.height(),
                    SizedBox(
                      height: 55,
                      child: MyTextField(
                        isObs: isObs,
                        suffix: GestureDetector(
                          onTap: onTap,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: isObs
                                ? SvgPicture.asset("asset/icons/eye-solid.svg",
                                    width: 10)
                                : SvgPicture.asset(
                                    IconUtil.eye,
                                    width: 10,
                                  ),
                          ),
                        ),
                        icon: IconUtil.lock,
                        hint: UtilsHelper.getString(context, 'password'),
                        controller: authController.passController.value,
                      ),
                    ),
                    SpaceUtils.ks40.height(),
                    Obx(() => authController.loading.isFalse
                        ? ArrowButton(
                            isBusy: isBusy,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              loginService(context);
                            },
                            tittle: UtilsHelper.getString(context, 'sign_in'),
                          )
                        : const CircularProgressIndicator(
                            color: ColorUtils.kcPrimary,
                          ))
                  ],
                )),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
