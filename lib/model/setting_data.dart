import 'package:water/model/setting_item.dart';
import 'language_item.dart';

class SettingData {
  SettingData({
    this.languages,
    this.setting,
  });

  List<LanguageItem>? languages;
  SettingItem? setting;

  factory SettingData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = {};
    json["setting"].forEach((x) {
      data[x['key']] = x['value'];
    });
    print(data.toString());
    return SettingData(
      setting: data.isNotEmpty ? SettingItem.fromJson(data) : null,
      languages: List<LanguageItem>.from(
          json["languages"].map((x) => LanguageItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "setting": setting!.toJson(),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
      };
}
