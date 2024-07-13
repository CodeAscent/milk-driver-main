// To parse this JSON data, do
//
//     final getOrderModel = getOrderModelFromJson(jsonString);

import 'dart:convert';

GetOrderModel getOrderModelFromJson(String str) =>
    GetOrderModel.fromJson(json.decode(str));

String getOrderModelToJson(GetOrderModel data) => json.encode(data.toJson());

class GetOrderModel {
  bool? success;
  Data? data;
  String? message;

  GetOrderModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
        success: json["success"],
        // data: json["data"] == null ? null : Data.fromJson(json["data"]),
        data: json["data"] == null ||
                json["data"] is Map && json["data"].isEmpty ||
                json['data'] == []
            ? null
            : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  int? userId;
  int? orderStatusId;
  int? deliveryAddressId;
  int? paymentId;
  double? promotionalDisount;
  int? isCouponApplied;
  String? couponCode;
  int? subtotal;
  double? finalAmount;
  int? tax;
  int? deliveryFee;
  String? paymentMethod;
  int? timeslotId;
  String? orderPlatform;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? bottlesNotReturnedCount;
  List<ProductOrdersDriver>? productOrdersDriver;
  Status? orderStatus;
  dynamic cancelRequest;
  UserOnly? userOnly;
  DeliveryAddress? deliveryAddress;

  Datum({
    this.id,
    this.userId,
    this.orderStatusId,
    this.deliveryAddressId,
    this.paymentId,
    this.promotionalDisount,
    this.isCouponApplied,
    this.couponCode,
    this.subtotal,
    this.finalAmount,
    this.tax,
    this.deliveryFee,
    this.paymentMethod,
    this.timeslotId,
    this.orderPlatform,
    this.createdAt,
    this.updatedAt,
    this.bottlesNotReturnedCount,
    this.productOrdersDriver,
    this.orderStatus,
    this.cancelRequest,
    this.userOnly,
    this.deliveryAddress,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderStatusId: json["order_status_id"],
        deliveryAddressId: json["delivery_address_id"],
        paymentId: json["payment_id"],
        // promotionalDisount: json["promotional_disount"],
        promotionalDisount: json["promotional_discount"] != null
            ? (json["promotional_discount"] is int
                ? (json["promotional_discount"] as int).toDouble()
                : json["promotional_discount"] as double)
            : null,
        isCouponApplied: json["is_coupon_applied"],
        couponCode: json["coupon_code"],
        subtotal: json["subtotal"],
        // finalAmount: json["final_amount"],
        finalAmount: json["final_amount"] != null
            ? (json["final_amount"] is int
                ? (json["final_amount"] as int).toDouble()
                : json["final_amount"] as double)
            : null,
        tax: json["tax"],
        deliveryFee: json["delivery_fee"],
        paymentMethod: json["payment_method"],
        timeslotId: json["timeslot_id"],
        orderPlatform: json["order_platform"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bottlesNotReturnedCount: json["bottles_not_returned_count"],
        productOrdersDriver: json["product_orders_driver"] == null
            ? []
            : List<ProductOrdersDriver>.from(json["product_orders_driver"]!
                .map((x) => ProductOrdersDriver.fromJson(x))),
        orderStatus: json["order_status"] == null
            ? null
            : Status.fromJson(json["order_status"]),
        cancelRequest: json["cancel_request"],
        userOnly: json["user_only"] == null
            ? null
            : UserOnly.fromJson(json["user_only"]),
        deliveryAddress: json["delivery_address"] == null
            ? null
            : DeliveryAddress.fromJson(json["delivery_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_status_id": orderStatusId,
        "delivery_address_id": deliveryAddressId,
        "payment_id": paymentId,
        "promotional_disount": promotionalDisount,
        "is_coupon_applied": isCouponApplied,
        "coupon_code": couponCode,
        "subtotal": subtotal,
        "final_amount": finalAmount,
        "tax": tax,
        "delivery_fee": deliveryFee,
        "payment_method": paymentMethod,
        "timeslot_id": timeslotId,
        "order_platform": orderPlatform,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bottles_not_returned_count": bottlesNotReturnedCount,
        "product_orders_driver": productOrdersDriver == null
            ? []
            : List<dynamic>.from(productOrdersDriver!.map((x) => x.toJson())),
        "order_status": orderStatus?.toJson(),
        "cancel_request": cancelRequest,
        "user_only": userOnly?.toJson(),
        "delivery_address": deliveryAddress?.toJson(),
      };
}

class DeliveryAddress {
  int? id;
  String? type;
  String? locationName;
  String? address;
  String? googleAddress;
  String? note;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? latitude;
  String? longitude;
  int? isDefault;
  int? userId;
  DateTime? createdAt;
  dynamic updatedAt;

  DeliveryAddress({
    this.id,
    this.type,
    this.locationName,
    this.address,
    this.googleAddress,
    this.note,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"],
        type: json["type"],
        locationName: json["location_name"],
        address: json["address"],
        googleAddress: json["google_address"],
        note: json["note"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipcode: json["zipcode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isDefault: json["is_default"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "location_name": locationName,
        "address": address,
        "google_address": googleAddress,
        "note": note,
        "city": city,
        "state": state,
        "country": country,
        "zipcode": zipcode,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}

class Status {
  int? id;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;

  Status({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        status: json["status"]!,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

// enum StatusEnum { PENDING, SHIPPED }

// final statusEnumValues =
//     EnumValues({"Pending": StatusEnum.PENDING, "Shipped": StatusEnum.SHIPPED});

class ProductOrdersDriver {
  int? id;
  int? userId;
  int? orderId;
  int? productId;
  int? quantity;
  int? perItemAmount;
  int? perDeliveryAmount;
  int? totalDeliveryAmount;
  int? noOfDelivery;
  String? orderFrequency;
  String? days;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  dynamic updatedAt;
  Product? product;
  List<ProductDeliverysStatus>? productDeliverysStatus;

  ProductOrdersDriver({
    this.id,
    this.userId,
    this.orderId,
    this.productId,
    this.quantity,
    this.perItemAmount,
    this.perDeliveryAmount,
    this.totalDeliveryAmount,
    this.noOfDelivery,
    this.orderFrequency,
    this.days,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.productDeliverysStatus,
  });

  factory ProductOrdersDriver.fromJson(Map<String, dynamic> json) =>
      ProductOrdersDriver(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        perItemAmount: json["per_item_amount"],
        perDeliveryAmount: json["per_delivery_amount"],
        totalDeliveryAmount: json["total_delivery_amount"],
        noOfDelivery: json["no_of_delivery"],
        orderFrequency: json["order_frequency"],
        days: json["days"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        productDeliverysStatus: json["product_deliverys_status"] == null
            ? []
            : List<ProductDeliverysStatus>.from(
                json["product_deliverys_status"]!
                    .map((x) => ProductDeliverysStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "per_item_amount": perItemAmount,
        "per_delivery_amount": perDeliveryAmount,
        "total_delivery_amount": totalDeliveryAmount,
        "no_of_delivery": noOfDelivery,
        "order_frequency": orderFrequency,
        "days": days,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "product": product?.toJson(),
        "product_deliverys_status": productDeliverysStatus == null
            ? []
            : List<dynamic>.from(
                productDeliverysStatus!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? sku;
  String? name;
  String? image;
  int? price;
  int? discountPrice;
  int? stock;
  String? description;
  int? minimumOrderQuantity;
  int? status;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Product({
    this.id,
    this.sku,
    this.name,
    this.image,
    this.price,
    this.discountPrice,
    this.stock,
    this.description,
    this.minimumOrderQuantity,
    this.status,
    this.image2,
    this.image3,
    this.image4,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        discountPrice: json["discount_price"],
        stock: json["stock"],
        description: json["description"],
        minimumOrderQuantity: json["minimum_order_quantity"],
        status: json["status"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "stock": stock,
        "description": description,
        "minimum_order_quantity": minimumOrderQuantity,
        "status": status,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class ProductDeliverysStatus {
  int? id;
  int? productOrderId;
  int? orderStatusId;
  Status? deliveryStatus;

  ProductDeliverysStatus({
    this.id,
    this.productOrderId,
    this.orderStatusId,
    this.deliveryStatus,
  });

  factory ProductDeliverysStatus.fromJson(Map<String, dynamic> json) =>
      ProductDeliverysStatus(
        id: json["id"],
        productOrderId: json["product_order_id"],
        orderStatusId: json["order_status_id"],
        deliveryStatus: json["delivery_status"] == null
            ? null
            : Status.fromJson(json["delivery_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_order_id": productOrderId,
        "order_status_id": orderStatusId,
        "delivery_status": deliveryStatus?.toJson(),
      };
}

class UserOnly {
  int? id;
  String? type;
  dynamic languageCode;
  String? name;
  dynamic image;
  String? email;
  String? phone;
  int? status;
  int? isVerified;
  int? enableNotification;
  int? otp;
  int? roleId;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  UserOnly({
    this.id,
    this.type,
    this.languageCode,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.status,
    this.isVerified,
    this.enableNotification,
    this.otp,
    this.roleId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserOnly.fromJson(Map<String, dynamic> json) => UserOnly(
        id: json["id"],
        type: json["type"],
        languageCode: json["language_code"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        phone: json["phone"],
        status: json["status"],
        isVerified: json["is_verified"],
        enableNotification: json["enable_notification"],
        otp: json["otp"],
        roleId: json["role_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "language_code": languageCode,
        "name": name,
        "image": image,
        "email": email,
        "phone": phone,
        "status": status,
        "is_verified": isVerified,
        "enable_notification": enableNotification,
        "otp": otp,
        "role_id": roleId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
