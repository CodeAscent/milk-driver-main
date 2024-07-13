import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water/API/get_notification_api.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/shadowedcontainer.dart';
import 'package:water/Utils/widgets/stackedscaffold.dart';
import 'package:water/utils/color_utils.dart';
import 'package:water/utils/icon_util.dart';
import 'package:water/utils/uttil_helper.dart';

import '../../utils/app_state.dart';
import '../home_screen/controller/home_controller.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());

  ScrollController? controller;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (controller!.position.extentAfter < 100) {
      if (notificationController.isPaging.isTrue) {
        notificationController.isPaging.value = false;
        getNotificationApi(url: notificationController.nextUrl.value);
      }
    }
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // deleteNotification();
        return true;
      },
      child: StackedScaffold(
        leadingIcon: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
          ),
          child: InkResponse(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
          ),
              onTap: () {
                //  deleteNotification();
                Navigator.pop(context);
              },
              child: Ink(
                padding: const EdgeInsets.all(14),
                child: Icon(
                UtilsHelper.rightHandLang.contains(appState.currentLanguageCode.value)? 
                 Icons.arrow_forward
                :Icons.arrow_back,
                color: isDark.value ? Colors.white : ColorUtils.kcSecondary),
              )),
        ),
        stackedEntries: const [],
        // actionIcon: InkResponse(
        //     onTap: () {},
        //     child: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     )),
        tittle: UtilsHelper.getString(context, 'notifications'),
        body: Obx(
          () => notificationController.notificationLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ColorUtils.kcPrimary,
                ))
              : notificationController.notificationList.isNotEmpty
                  ? Column(
                      children: [
                        SpaceUtils.ks100.height(),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                notificationController.notificationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CommonShadowContainer(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 27, right: 27),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 17),
                                child: Row(
                                  children: [
                                   notificationController.notificationList[index].title == 'Cancelled'
                                     ? Image.asset('asset/images/failure_toast.png',
                                    width: 30,height: 30,
                                    color: Colors.red,
                                    ) : Image.asset('asset/images/success_toast.png',
                                    width: 30,height: 30,
                                    color: Colors.green,
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          UtilsHelper.getString(context, 
                                          "${notificationController.notificationList[index].message}") ?? "",
                                          style: FontStyleUtilities.h6(
                                            fontColor: ColorUtils.kcPrimary,
                                              fontWeight: FWT.bold),
                                        ),
                                        SpaceUtils.ks7.height(),
                                        Text(
                                          '${formatter.format(DateTime.parse(notificationController.notificationList[index].createdAt.toString()))} | ${formatter1.format(DateTime.parse(notificationController.notificationList[index].createdAt.toString()))}',
                                          style: FontStyleUtilities.t5(
                                              fontWeight: FWT.medium),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Obx(() => notificationController
                                .paginationLoading.isTrue
                            ? const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 12, top: 6),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox()),
                      ],
                    )
                  : const Center(
                      child: Text(
                        "Notification Not Found",
                        style: TextStyle(
                            fontSize: 22,
                            color: ColorUtils.kcPrimary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
        ),
      ),
    );
  }
}
