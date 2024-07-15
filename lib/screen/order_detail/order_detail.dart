///FRAME WORK IMPORT...
// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///PACKAGES DEPENDED ON...
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/API/change_order_status_api.dart';
import 'package:water/API/collect_bottle_count_api.dart';
import 'package:water/API/get_notification_api.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/Utils/color_utils.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/icon_util.dart';

/// BASE CONFIGURED COMPONENTS ...
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/arrowbutton.dart';
import 'package:water/Utils/widgets/loader.dart';
import 'package:water/Utils/widgets/shadowedcontainer.dart';
import 'package:water/Utils/widgets/stackedscaffold.dart';
import 'package:water/main.dart';
import 'package:water/model/get_order_model.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/screen/home_screen/home_screen.dart';
import 'package:water/screen/map_screen/map.dart';
import 'package:water/screen/notification_screen/nofication.dart';
import 'package:water/utils/shimmer.dart';

import '../../utils/app_state.dart';
import '../../utils/uttil_helper.dart';

class OrderDetails extends StatefulWidget {
  final Map<String, dynamic> orderData;
  final bool orderHistory;

  const OrderDetails(
      {Key? key, required this.orderData, required this.orderHistory})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController noOfBottle = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  // String dropdownValue = 'No';
  String? dropdownValue;
  String? isBottleCollected;

  int selectedIndex = 1;
  late Datum order;

  void setIndex(int index) {
    selectedIndex = index;
    setState(() {});
  }

  String selectedStatus = "";
  String? selectedStatusId;

  _launchCaller({mobileNumber}) async {
    var url = "tel:$mobileNumber";
    // if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  void initState() {
    super.initState();
    order = widget.orderData['data'];
    selectedStatus = widget.orderData['data'].productOrdersDriver![0]
                    .productDeliverysStatus !=
                null &&
            widget.orderData['data'].productOrdersDriver![0]
                    .productDeliverysStatus !=
                null &&
            widget.orderData['data'].productOrdersDriver![0]
                .productDeliverysStatus!.isNotEmpty
        ? widget.orderData['data'].productOrdersDriver![0]
            .productDeliverysStatus![0].deliveryStatus!.status
            .toString()
        : '';
    selectedStatusId = widget.orderData['data'].productOrdersDriver![0]
                    .productDeliverysStatus !=
                null &&
            widget.orderData['data'].productOrdersDriver![0]
                .productDeliverysStatus!.isNotEmpty
        ? widget.orderData['data'].productOrdersDriver![0]
            .productDeliverysStatus![0].orderStatusId
            .toString()
        : null;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.orderData['data'].productOrdersDriver![0]
              .productDeliverysStatus ==
          null) {
        await getOrderDetail(url: widget.orderData['data'].id.toString())
            .then((value) {
          order = value;
          selectedStatus =
              order.productOrdersDriver![0].productDeliverysStatus != null
                  ? order.productOrdersDriver![0].productDeliverysStatus![0]
                      .deliveryStatus!.status
                      .toString()
                  : '';
          selectedStatusId =
              order.productOrdersDriver![0].productDeliverysStatus != null
                  ? order.productOrdersDriver![0].productDeliverysStatus![0]
                      .toString()
                  : null;
          setState(() {});
        });
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: PopScope(
        canPop: true,
        onPopInvoked: (val) async {
          //Get.back();
          if (widget.orderHistory == false) {
            getOrderApi(url: "", orderHistory: widget.orderHistory);
          }
        },
        child: StackedScaffold(
          actionIcon: Stack(
            children: [
              Transform.scale(
                scale: .8,
                child: CustomIconButton(
                  path: IconUtil.bell,
                  onTap: () {
                    getNotificationApi(url: "");
                    Get.to(() => const NotificationScreen());
                  },
                ),
              ),
              Obx(
                () => authController.notificationCount.value.toString() == "0"
                    ? const SizedBox()
                    : Positioned(
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Text(
                            authController.notificationCount.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              )
            ],
          ),
          leadingIcon: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkResponse(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onTap: () {
                Get.back();
                if (widget.orderHistory == false) {
                  getOrderApi(url: "", orderHistory: widget.orderHistory);
                }
              },
              child: Ink(
                padding: const EdgeInsets.all(14),
                child: Icon(
                    UtilsHelper.rightHandLang
                            .contains(appState.currentLanguageCode.value)
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    color:
                        isDark.value ? Colors.white : ColorUtils.kcSecondary),
              ),
            ),
          ),
          stackedEntries: const [],
          tittle: UtilsHelper.getString(context, 'order_details'),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceUtils.ks18.height(),
                    SpaceUtils.ks120.height(),
                    order.productOrdersDriver == null
                        ? const ShimmerLoader(height: 100)
                        : orderDetailFirstTile(
                            orderData: order, productData: widget.orderData),
                    SpaceUtils.ks24.height(),
                    order.productOrdersDriver == null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Row(
                              children: [
                                Expanded(child: ShimmerLoader(height: 60)),
                                Expanded(child: ShimmerLoader(height: 60)),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 27),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: ArrowButton(
                                    isUpdate: true,
                                    onTap: () => setIndex(1),
                                    tittle: UtilsHelper.getString(
                                        context, 'ordered_products'),
                                    color: selectedIndex == 1
                                        ? ColorUtils.kcPrimary
                                        : isDark.value
                                            ? ColorUtils.kcBlack
                                                .withOpacity(0.34)
                                            : ColorUtils.kcLightTextColor,
                                  ),
                                ),
                                SpaceUtils.ks10.width(),
                                Expanded(
                                  flex: 3,
                                  child: ArrowButton(
                                    isUpdate: true,
                                    onTap: () => setIndex(0),
                                    tittle: UtilsHelper.getString(
                                        context, 'customer'),
                                    color: selectedIndex == 0
                                        ? ColorUtils.kcPrimary
                                        : isDark.value
                                            ? ColorUtils.kcBlack
                                                .withOpacity(0.34)
                                            : ColorUtils.kcLightTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SpaceUtils.ks24.height(),
                    order.productOrdersDriver == null
                        ? const ShimmerLoader(height: 250)
                        : selectedIndex == 0
                            ? secondTile(orderDetail: order)
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 27, right: 27),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        UtilsHelper.getString(
                                            context, 'products'),
                                        style: FontStyleUtilities.h5(
                                            fontWeight: FWT.semiBold),
                                      ),
                                      SpaceUtils.ks10.height(),
                                      ...order.productOrdersDriver!.map(
                                          (e) => productsTile(orderDetail: e))
                                    ]),
                              ),
                    SpaceUtils.ks24.height(),
                    Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Text(
                        UtilsHelper.getString(context, 'Delivery Status'),
                        style: FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                      ),
                    ),
                    SpaceUtils.ks10.height(),
                    order.productOrdersDriver == null
                        ? const ShimmerLoader(height: 250)
                        : paymentSummary(orderDetail: order),
                    SpaceUtils.ks24.height(),
                    order.productOrdersDriver == null
                        ? const ShimmerLoader(height: 250)
                        : collectedSummary(orderDetail: order),
                    SpaceUtils.ks40.height(),
                  ],
                ),
              ),
              Obx(() => homeController.detailLoading.isTrue
                  ? const Loader()
                  : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }

  Widget secondTile({required Datum orderDetail}) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 27, right: 27, top: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          secondTileSubTile(
            tap: () {},
            title: UtilsHelper.getString(context, 'name'),
            description: orderDetail.userOnly!.name != null
                ? orderDetail.userOnly!.name.toString()
                : "         --",
            path: IconUtil.user,
          ),
          secondTileSubTile(
            tap: () async {
              bool v = await Permission.location.request().isGranted;
              if (!v) {
                await Permission.location.request();
              } else {
                Get.to(
                  () => MapScreen(
                    userLongitude: double.parse(
                        orderDetail.deliveryAddress!.longitude.toString()),
                    userLatitude: double.parse(
                        orderDetail.deliveryAddress!.latitude.toString()),
                    date:
                        "${formatter.format(DateTime.parse(orderDetail.createdAt.toString()))} | ${formatter1.format(DateTime.parse(orderDetail.createdAt.toString()))}",
                    items: orderDetail.productOrdersDriver!.length.toString(),
                    paymentMethod: orderDetail.paymentMethod.toString(),
                  ),
                );
              }
            },
            title: UtilsHelper.getString(context, 'delivery_address'),
            description: orderDetail.deliveryAddress!.googleAddress ?? "",
            path: IconUtil.location,
          ),
          secondTileSubTile(
            tap: () async {
              await _launchCaller(
                  mobileNumber: orderDetail.userOnly!.phone.toString());
            },
            title: UtilsHelper.getString(context, 'phone_number') ??
                'Phone Number ',
            description: orderDetail.userOnly!.phone != null
                ? orderDetail.userOnly!.phone.toString()
                : "",
            path: IconUtil.call,
          ),
        ],
      ),
    );
  }

  Widget secondTileSubTile({title, description, tap, path}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FontStyleUtilities.h6(fontWeight: FWT.semiBold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: FontStyleUtilities.t1(
                          fontColor: ColorUtils.kcLightTextColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: tap,
            child: CircleAvatar(
              foregroundColor: ColorUtils.kcWhite,
              backgroundColor: ColorUtils.kcPrimary,
              child: SvgPicture.asset(path, color: ColorUtils.kcWhite),
            ),
          )
        ],
      ),
    );
  }

  Widget productsTile({required ProductOrdersDriver orderDetail}) {
    print(
        "${ApiUrls.basicUrl}app-assets/images/products/${orderDetail.product!.image}");
    return CommonShadowContainer(
      height: 110,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          // SpaceUtils.ks8.height(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${ApiUrls.basicUrl}app-assets/images/products/${orderDetail.product!.image}",
                      placeholder: (context, url) {
                        return const ShimmerLoader(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.zero,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          "asset/images/failure_toast.png",
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ),
                SpaceUtils.ks8.width(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        orderDetail.product == null
                            ? ''
                            : orderDetail.product!.name.toString(),
                        style: FontStyleUtilities.h6(fontWeight: FWT.semiBold),
                      ),
                      SpaceUtils.ks8.height(),
                      orderDetail.product != null &&
                              orderDetail.product!.discountPrice.toString() !=
                                  "null" &&
                              orderDetail.product!.discountPrice.toString() !=
                                  "0" &&
                              orderDetail.product!.discountPrice.toString() !=
                                  "0.0"
                          ? Text(
                              ' ${orderDetail.product!.discountPrice.toString()} ${appState.setting.value.setting!.defaultCurrencyCode}  x  ${orderDetail.quantity.toString()}',
                              textAlign: TextAlign.right,
                              style: FontStyleUtilities.t1(),
                            )
                          : orderDetail.product == null
                              ? const Text('')
                              : Text(
                                  '${orderDetail.product!.price.toString()} ${appState.setting.value.setting!.defaultCurrencyCode}  x  ${orderDetail.quantity.toString()}',
                                  style: FontStyleUtilities.p1(),
                                  textAlign: TextAlign.right)
                    ],
                  ),
                ),
                // const Spacer(),
                //  Checkbox.adaptive(
                //   value: ,
                //   onChanged: (val){

                //   })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderDetailFirstTile(
      {required Datum orderData, required dynamic productData}) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 27, right: 27, top: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${UtilsHelper.getString(context, 'order_id')}: #${productData['data'].id.toString()}',
                style: FontStyleUtilities.t1(
                  fontColor: ColorUtils.kcLightTextColor,
                  fontWeight: FWT.bold,
                ),
              ),
              Text(
                '${orderData.finalAmount.toString()}  ${appState.setting.value.setting!.defaultCurrencyCode}',
                style: FontStyleUtilities.h5(fontWeight: FWT.bold),
              )
            ],
          ),
          SpaceUtils.ks14.height(),
          Row(
            children: [
              Expanded(
                child: Text(
                  UtilsHelper.getString(
                      context, selectedStatus.toString().split(' ').join('_')),
                  style: FontStyleUtilities.h5(fontWeight: FWT.bold),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${orderData.productOrdersDriver!.length.toString()} ${UtilsHelper.getString(context, 'items')}',
                style: FontStyleUtilities.t1(
                  fontColor: ColorUtils.kcLightTextColor,
                ),
              ),
            ],
          ),
          SpaceUtils.ks10.height(),
          Row(
            children: [
              Text(
                  "Collect bottles: ${widget.orderData['data'].bottlesNotReturnedCount}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentSummary({required Datum orderDetail}) {
    return CommonShadowContainer(
      margin: const EdgeInsets.symmetric(horizontal: 27),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Subtotal',
          //         style: FontStyleUtilities.t1(
          //             fontColor: ColorUtils.kcLightTextColor)),
          //     Text('${orderDetail.order!.subtotal} SAR',
          //         style: FontStyleUtilities.h5(fontWeight: FWT.semiBold)),
          //   ],
          // ),
          // SpaceUtils.ks7.height(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('TAX',
          //         style: FontStyleUtilities.t1(
          //             fontColor: ColorUtils.kcLightTextColor)),
          //     Text('${orderDetail.order!.tax} SAR',
          //         style: FontStyleUtilities.h5(fontWeight: FWT.semiBold)),
          //   ],
          // ),
          // SpaceUtils.ks10.height(),
          // const Divider(
          //   thickness: 1,
          //   height: 1,
          //   color: ColorUtils.kcDividerColor,
          // ),
          SpaceUtils.ks10.height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(UtilsHelper.getString(context, 'total'),
                  style: FontStyleUtilities.t1(
                    fontWeight: FWT.bold,
                  )),
              Text(
                  '${orderDetail.finalAmount.toString()} ${appState.setting.value.setting!.defaultCurrencyCode}',
                  style: FontStyleUtilities.h5(fontWeight: FWT.bold)),
            ],
          ),
          widget.orderHistory == true ? const SizedBox() : statusDropDown(),
          widget.orderHistory == true
              ? const SizedBox()
              : const Divider(
                  thickness: 1,
                  height: 1,
                  color: ColorUtils.kcDividerColor,
                ),
          SpaceUtils.ks10.height(),
        ],
      ),
    );
  }

  Widget statusDropDown() {
    return SizedBox(
      // decoration: widget.decoration,
      height: 40,
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedStatusId,
        dropdownColor: Theme.of(context).cardColor,
        icon: const Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: ColorUtils.kcPrimary,
            )),
        iconSize: 30,
        elevation: 16,
        style: FontStyleUtilities.t2(
            fontWeight: FWT.semiBold, fontColor: ColorUtils.kcLightTextColor),
        underline: Container(color: ColorUtils.kcTransparent),
        onChanged: (String? newValue) {
          if (newValue != null) {
            selectedStatusId = newValue;
            setState(() {});
            changeStatus(
                statusId: selectedStatusId,
                orderId: widget.orderData['product'].id);
          }
        },
        items: authController.orderStatusList
            .map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem(
            onTap: () {
              selectedStatus = value.status!;
              setState(() {});
              print(selectedStatus);
            },
            value: value.id.toString(),
            child: Text(
                appState.languageKeys.containsKey(
                        value.status!.toLowerCase().split(' ').join('_'))
                    ? UtilsHelper.getString(context,
                        value.status!.toLowerCase().split(' ').join('_'))
                    : value.status!,
                style: TextStyle(
                    color:
                        dark(context) ? Colors.white : ColorUtils.kcSecondary)),
          );
        }).toList(),
      ),
    );
  }

  Widget collectedSummary({required Datum orderDetail}) {
    return Visibility(
      visible: widget.orderData['data'].bottlesNotReturnedCount != 0,
      child: CommonShadowContainer(
        margin: const EdgeInsets.symmetric(horizontal: 27),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SpaceUtils.ks10.height(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    UtilsHelper.getString(
                        context, 'Have You Collected Empty Bottle ?'),
                    style: FontStyleUtilities.t1(
                      fontWeight: FWT.bold,
                    )),
              ],
            ),
            widget.orderHistory == true
                ? const SizedBox()
                : collectedBottleDropDown(),
            widget.orderHistory == true
                ? const SizedBox()
                : const Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorUtils.kcDividerColor,
                  ),
            SpaceUtils.ks20.height(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    UtilsHelper.getString(
                        context, 'How many bottles collected?'),
                    style: FontStyleUtilities.t1(
                      fontWeight: FWT.bold,
                    )),
              ],
            ),
            SpaceUtils.ks10.height(),
            widget.orderHistory == true
                ? const SizedBox()
                : TextFormField(
                    controller: noOfBottle,
                    validator: (value) {
                      if (dropdownValue == 'Yes') {
                        if (noOfBottle.text == '') {
                          return 'Please enter a bottle count';
                        }
                        if (noOfBottle.text == 0.toString()) {
                          return 'Bottle count must be more than 0.';
                        }
                      } else if (dropdownValue == 'Damaged') {
                        if (noOfBottle.text == '') {
                          return 'Please enter a bottle count';
                        }
                        if (noOfBottle.text == 0.toString()) {
                          return 'Bottle count must be more than 0.';
                        }
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    readOnly: dropdownValue == 'No' ||
                        dropdownValue == 'Not applicable',

                    // obscureText: isObs!,
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter number of bottles collected",
                        hintStyle: FontStyleUtilities.t1(
                            fontWeight: FWT.medium,
                            fontColor: ColorUtils.kcLightTextColor)),
                    textAlign: TextAlign.left,
                    style: FontStyleUtilities.t1(
                        fontWeight: FWT.medium,
                        fontColor: ColorUtils.kcLightTextColor)),
            Visibility(
              visible: dropdownValue == 'Damaged',
              child: Column(
                children: [
                  SpaceUtils.ks10.height(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(UtilsHelper.getString(context, 'Reason?'),
                          style: FontStyleUtilities.t1(
                            fontWeight: FWT.bold,
                          )),
                    ],
                  ),
                  SpaceUtils.ks10.height(),
                  widget.orderHistory == true
                      ? const SizedBox()
                      : TextFormField(
                          controller: reasonController,
                          validator: (value) {
                            if (value == '') {
                              return 'Please write a reason.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          readOnly: dropdownValue == 'No' ||
                              dropdownValue == 'Not applicable',

                          // obscureText: isObs!,
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter the reason for damaged bottles",
                              hintStyle: FontStyleUtilities.t1(
                                  fontWeight: FWT.medium,
                                  fontColor: ColorUtils.kcLightTextColor)),
                          textAlign: TextAlign.left,
                          style: FontStyleUtilities.t1(
                              fontWeight: FWT.medium,
                              fontColor: ColorUtils.kcLightTextColor)),
                ],
              ),
            ),
            SpaceUtils.ks20.height(),
            Obx(() => ArrowButton(
                  isBusy: homeController.updateLoading.value,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      Logger().w(widget.orderData['product']!.id.toString());
                      updateCollectedBottle(
                          isBottleCollected!,
                          noOfBottle.text.toString(),
                          widget.orderData['product']!.id.toString(),
                          reasonController.text);
                    }
                  },
                  tittle: "Submit",
                ))
          ],
        ),
      ),
    );
  }

  Widget collectedBottleDropDown() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        hint: const Text("Select Option"),
        value: dropdownValue,
        dropdownColor: Theme.of(context).cardColor,
        icon: const Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: ColorUtils.kcPrimary,
            )),
        iconSize: 30,
        elevation: 16,
        style: FontStyleUtilities.t2(
            fontWeight: FWT.semiBold, fontColor: ColorUtils.kcLightTextColor),
        underline: Container(color: ColorUtils.kcTransparent),
        onChanged: (String? newValue) {
          setState(() {
            reasonController.clear();
            dropdownValue = newValue!;
            if (newValue == 'No' || newValue == 'Not applicable') {
              noOfBottle.text = 0.toString();
            }
            if (newValue == 'No') {
              isBottleCollected = 0.toString();
            } else if (newValue == 'Yes') {
              isBottleCollected = 1.toString();
            } else if (newValue == 'Damaged') {
              isBottleCollected = 2.toString();
            } else if (newValue == 'Not applicable') {
              isBottleCollected = 3.toString();
            }
            print(isBottleCollected);
          });
        },
        items: <String>['Yes', 'No', 'Damaged', 'Not applicable']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                    color:
                        dark(context) ? Colors.white : ColorUtils.kcSecondary)),
          );
        }).toList(),
      ),
    );
  }
}
