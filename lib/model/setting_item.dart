class SettingItem {
  String? timezone;
  String? language;
  String? fcmKey;
  String? defaultTax;
  String? shippingCharge;
  String? minimumOrderValue;
  String? currencyRight;
  String? defaultCurrency;
  String? defaultCurrencyCode;
  String? defaultCurrencyDecimalDigits;
  String? defaultCurrencyRounding;
  String? deliverTurnaroundDays;
  String? maxDeliveryExtension;
  String? facebookUrl;
  String? twitterUrl;
  String? instagramUrl;
  String? pinterestUrl;
  String? snapchatUrl;
  String? enableStripe;
  String? stripeKey;
  String? stripeSecret;
  String? enableRazorpay;
  String? razorpayKey;
  String? razorpaySecret;
  String? enableEghl;
  String? eghlServiceid;
  String? eghlPassword;
  String? youtubeVideoUrl;
  String? appleDownloadUrl;
  String? androidDownloadUrl;
  String? contactPhone;
  String? contactEmail;
  String? contactAddress;
  String? supportPhone;
  String? contactSupportPhone;
  String? siteTitle;
  String? siteAuthor;
  String? siteDescription;
  String? siteKeyword;
  String? googleAnalysis;
  String? websiteLogo;
  String? aboutProduct;
  String? mobileImage;
  String? icon1;
  String? icon2;
  String? icon3;
  String? icon4;
  String? websiteBgImage;
  String? enablePaylab;
  String? enableCod;
  String? enableWallet;
  String? monWorking;
  String? tueWorking;
  String? wedWorking;
  String? thuWorking;
  String? friWorking;
  String? satWorking;
  String? sunWorking;
  String? enableOppwa;
  String? dateFormat;
  String? dateTimeFormat;
  String? timeFormat;

  SettingItem(
      {this.timezone,
      this.language,
      this.fcmKey,
      this.defaultTax,
      this.shippingCharge,
      this.minimumOrderValue,
      this.currencyRight,
      this.defaultCurrency,
      this.defaultCurrencyCode,
      this.defaultCurrencyDecimalDigits,
      this.defaultCurrencyRounding,
      this.deliverTurnaroundDays,
      this.maxDeliveryExtension,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.pinterestUrl,
      this.snapchatUrl,
      this.enableStripe,
      this.stripeKey,
      this.stripeSecret,
      this.enableRazorpay,
      this.razorpayKey,
      this.razorpaySecret,
      this.enableEghl,
      this.eghlServiceid,
      this.eghlPassword,
      this.youtubeVideoUrl,
      this.appleDownloadUrl,
      this.androidDownloadUrl,
      this.contactPhone,
      this.contactEmail,
      this.contactAddress,
      this.supportPhone,
      this.contactSupportPhone,
      this.siteTitle,
      this.siteAuthor,
      this.siteDescription,
      this.siteKeyword,
      this.googleAnalysis,
      this.websiteLogo,
      this.aboutProduct,
      this.mobileImage,
      this.icon1,
      this.icon2,
      this.icon3,
      this.icon4,
      this.websiteBgImage,
      this.enablePaylab,
      this.enableCod,
      this.enableWallet,
      this.monWorking,
      this.tueWorking,
      this.wedWorking,
      this.thuWorking,
      this.friWorking,
      this.satWorking,
      this.sunWorking,
      this.enableOppwa,
      this.dateFormat,
      this.dateTimeFormat,
      this.timeFormat});

  factory SettingItem.fromJson(Map<String, dynamic> json) {
  print(json);
   return SettingItem(
    timezone : json['timezone'],
    language : json['language'],
    fcmKey : json['fcm_key'],
    defaultTax : json['default_tax'],
    shippingCharge : json['shipping_charge'],
    minimumOrderValue : json['minimum_order_value'],
    currencyRight : json['currency_right'],
    defaultCurrency : json['default_currency'],
    defaultCurrencyCode : json['default_currency_code'],
    defaultCurrencyDecimalDigits : json['default_currency_decimal_digits'],
    defaultCurrencyRounding : json['default_currency_rounding'],
    deliverTurnaroundDays : json['deliver_turnaround_days'],
    maxDeliveryExtension : json['max_delivery_extension'],
    facebookUrl : json['facebook_url'],
    twitterUrl : json['twitter_url'],
    instagramUrl : json['instagram_url'],
    pinterestUrl : json['pinterest_url'],
    snapchatUrl : json['snapchat_url'],
    enableStripe : json['enable_stripe'],
    stripeKey : json['stripe_key'],
    stripeSecret : json['stripe_secret'],
    enableRazorpay : json['enable_razorpay'],
    razorpayKey : json['razorpay_key'],
    razorpaySecret : json['razorpay_secret'],
    enableEghl : json['enable_eghl'],
    eghlServiceid : json['eghl_serviceid'],
    eghlPassword : json['eghl_password'],
    youtubeVideoUrl : json['youtube_video_url'],
    appleDownloadUrl : json['apple_download_url'],
    androidDownloadUrl : json['android_download_url'],
    contactPhone : json['contact_phone'],
    contactEmail : json['contact_email'],
    contactAddress : json['contact_address'],
    supportPhone : json['support_phone'],
    contactSupportPhone : json['contact_support_phone'],
    siteTitle : json['site_title'],
    siteAuthor : json['site_author'],
    siteDescription : json['site_description'],
    siteKeyword : json['site_keyword'],
    googleAnalysis : json['google_analysis'],
    websiteLogo : json['website_logo'],
    aboutProduct : json['about_product'],
    mobileImage : json['mobile_image'],
    icon1 : json['icon_1'],
    icon2 : json['icon_2'],
    icon3 : json['icon_3'],
    icon4 : json['icon_4'],
    websiteBgImage : json['website_bg_image'],
    enablePaylab : json['enable_paylab'],
    enableCod : json['enable_cod'],
    enableWallet : json['enable_wallet'],
    monWorking : json['mon_working'],
    tueWorking : json['tue_working'],
    wedWorking : json['wed_working'],
    thuWorking : json['thu_working'],
    friWorking : json['fri_working'],
    satWorking : json['sat_working'],
    sunWorking : json['sun_working'],
    enableOppwa : json['enable_oppwa'],
    dateFormat : json['date_format'],
    dateTimeFormat : json['date_time_format'],
    timeFormat : json['time_format']
  );
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['timezone'] = timezone;
    data['language'] = language;
    data['fcm_key'] = fcmKey;
    data['default_tax'] = defaultTax;
    data['shipping_charge'] = shippingCharge;
    data['minimum_order_value'] = minimumOrderValue;
    data['currency_right'] = currencyRight;
    data['default_currency'] = defaultCurrency;
    data['default_currency_code'] = defaultCurrencyCode;
    data['default_currency_decimal_digits'] = defaultCurrencyDecimalDigits;
    data['default_currency_rounding'] = defaultCurrencyRounding;
    data['deliver_turnaround_days'] = deliverTurnaroundDays;
    data['max_delivery_extension'] = maxDeliveryExtension;
    data['facebook_url'] = facebookUrl;
    data['twitter_url'] = twitterUrl;
    data['instagram_url'] = instagramUrl;
    data['pinterest_url'] = pinterestUrl;
    data['snapchat_url'] = snapchatUrl;
    data['enable_stripe'] = enableStripe;
    data['stripe_key'] = stripeKey;
    data['stripe_secret'] = stripeSecret;
    data['enable_razorpay'] = enableRazorpay;
    data['razorpay_key'] = razorpayKey;
    data['razorpay_secret'] = razorpaySecret;
    data['enable_eghl'] = enableEghl;
    data['eghl_serviceid'] = eghlServiceid;
    data['eghl_password'] = eghlPassword;
    data['youtube_video_url'] = youtubeVideoUrl;
    data['apple_download_url'] = appleDownloadUrl;
    data['android_download_url'] = androidDownloadUrl;
    data['contact_phone'] = contactPhone;
    data['contact_email'] = contactEmail;
    data['contact_address'] = contactAddress;
    data['support_phone'] = supportPhone;
    data['contact_support_phone'] = contactSupportPhone;
    data['site_title'] = siteTitle;
    data['site_author'] = siteAuthor;
    data['site_description'] = siteDescription;
    data['site_keyword'] = siteKeyword;
    data['google_analysis'] = googleAnalysis;
    data['website_logo'] = websiteLogo;
    data['about_product'] = aboutProduct;
    data['mobile_image'] = mobileImage;
    data['icon_1'] = icon1;
    data['icon_2'] = icon2;
    data['icon_3'] = icon3;
    data['icon_4'] = icon4;
    data['website_bg_image'] = websiteBgImage;
    data['enable_paylab'] = enablePaylab;
    data['enable_cod'] = enableCod;
    data['enable_wallet'] = enableWallet;
    data['mon_working'] = monWorking;
    data['tue_working'] = tueWorking;
    data['wed_working'] = wedWorking;
    data['thu_working'] = thuWorking;
    data['fri_working'] = friWorking;
    data['sat_working'] = satWorking;
    data['sun_working'] = sunWorking;
    data['enable_oppwa'] = enableOppwa;
    data['date_format'] = dateFormat;
    data['date_time_format'] = dateTimeFormat;
    data['time_format'] = timeFormat;
    return data;
  }
}