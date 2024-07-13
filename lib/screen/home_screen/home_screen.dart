import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/main.dart';
import 'package:water/screen/home_screen/Profile/profile.dart';
import 'package:water/screen/home_screen/order_screen/order_history.dart';
import 'package:water/screen/home_screen/order_screen/order_screen.dart';
import 'package:water/utils/app_state.dart';
import 'package:water/utils/color_utils.dart';
import 'package:water/utils/custom_package/lazyindexedstack.dart';
import 'package:water/utils/custom_package/visibilitybuilder.dart';
import 'package:water/utils/icon_util.dart';
import 'package:water/utils/uttil_helper.dart';

import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  @override
  void initState() {
    gets.remove('url');
    super.initState();
    UtilsHelper.loadLocalization(appState.currentLanguageCode.value);
  }

  onTap(int index) {
    selectedIndex = index;
    if (index == 2) {
      getOrderApi(url: "", orderHistory: true);
    }
    if (index == 1) {
      getOrderApi(url: "", orderHistory: false);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: KeyboardVisibilityBuilder(
        builder: (context, child, isVisible) =>
            isVisible ? const SizedBox() : child!,
        child: Material(
          type: MaterialType.circle,
          color: Colors.white,
          elevation: 5,
          child: GestureDetector(
            onTap: () {
              onTap(1);
              authController.updateProfile.value = false;
            },
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 1
                      ? ColorUtils.kcPrimary
                      : ColorUtils.kcSecondary),
              child: Container(
                // color: ColorUtils.kcWhite,
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(IconUtil.store),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          notchMargin: 10,
          color: Theme.of(context).cardColor,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      onTap(0);
                      authController.updateProfile.value = false;
                    },
                    path: IconUtil.users),
                CustomIconButton(
                    isSelected: selectedIndex == 2,
                    onTap: () {
                      onTap(2);
                      authController.updateProfile.value = false;
                    },
                    path: IconUtil.clock)
              ],
            ),
          ),
        ),
      ),
      body: LazyIndexedStack(
        index: selectedIndex,
        children: const [
          Profile(),
          OrderList(orderHistory: false),
          OrderHistory(),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      this.isSelected = false,
      required this.onTap,
      this.color,
      required this.path});
  final VoidCallback onTap;
  final Color? color;
  final String path;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected == true ? ColorUtils.kcPrimary : Colors.transparent,
        ),
        child: SvgPicture.asset(
          path,
          color: isDark.value
              ? color ?? Colors.white
              : isSelected == true
                  ? Colors.white
                  : color ?? ColorUtils.kcSecondary,
          theme: SvgTheme(
              currentColor: isDark.value
                  ? Colors.white
                  : isSelected == true
                      ? Colors.white
                      : ColorUtils.kcSecondary),
        ),
      ),
      onPressed: () => onTap(),
    );
  }
}
