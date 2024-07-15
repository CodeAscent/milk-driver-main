import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:water/Utils/color_utils.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/arrowbutton.dart';
import 'package:water/Utils/widgets/shadowedcontainer.dart';
import 'package:water/model/get_order_model.dart';
import 'package:water/screen/order_detail/order_detail.dart';
import 'package:water/utils/icon_util.dart';

import '../../../../utils/app_state.dart';
import '../../../../utils/uttil_helper.dart';

class OrderTile extends StatefulWidget {
  final dynamic orderData;
  final bool orderHistory;
  final String? currency;
  final void Function() onTap;

  const OrderTile(
      {super.key,
      required this.orderData,
      this.currency,
      required this.orderHistory,
      required this.onTap});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 27, right: 27, top: 20),
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Row(
            children: [
              SpaceUtils.ks16.width(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceUtils.ks16.height(),
                    Row(
                      children: [
                        Text(
                          widget.orderData['data'].productOrdersDriver![0]
                              .productDeliverysStatus![0].deliveryStatus!.status
                              .toString(),
                          style: FontStyleUtilities.h5(fontWeight: FWT.bold),
                        ),
                        const Spacer(),
                        Text(
                          appState.setting.value.setting != null
                              ? '${widget.orderData['data'].finalAmount.toString()} ${widget.currency}'
                              : widget.orderData['data'].finalAmount.toString(),
                          style: FontStyleUtilities.h5(fontWeight: FWT.bold),
                        ),
                      ],
                    ),
                    SpaceUtils.ks7.height(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${UtilsHelper.getString(context, 'order_id')} : #${widget.orderData['data'].id}',
                              style: FontStyleUtilities.t1(
                                  fontColor: ColorUtils.kcLightTextColor,
                                  fontWeight: FWT.bold),
                            ),
                            SpaceUtils.ks7.height(),
                            Text(
                              '${formatter.format(DateTime.parse(widget.orderData['product'].deliveryDate.toString()))} ',
                              style: FontStyleUtilities.t1(
                                fontColor: ColorUtils.kcLightTextColor,
                              ),
                            ),
                            SpaceUtils.ks7.height(),
                            Text(
                              '${UtilsHelper.getString(context, 'customer')} : ${widget.orderData["data"].userOnly.name != null ? widget.orderData["data"].userOnly.name : "  --"}',
                              style: FontStyleUtilities.t1(
                                fontColor: ColorUtils.kcLightTextColor,
                              ),
                            ),
                            SpaceUtils.ks7.height(),
                            Text(
                              'Collect Bottles: ${widget.orderData['data'].bottlesNotReturnedCount}',
                              style: FontStyleUtilities.t1(
                                fontColor: ColorUtils.kcLightTextColor,
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   '${widget.orderData['data'].productOrdersDriver!.length} ${UtilsHelper.getString(context, 'items')}',
                        //   style: FontStyleUtilities.t1(
                        //     fontColor: ColorUtils.kcLightTextColor,
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(height: 14),
                    ArrowButton(
                      onTap: widget.onTap,
                      tittle: UtilsHelper.getString(context, 'view_details'),
                    ),
                    SpaceUtils.ks16.height(),
                  ],
                ),
              ),
              SpaceUtils.ks16.width(),
            ],
          ),
        ],
      ),
    );
  }
}
