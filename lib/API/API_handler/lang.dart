
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/setting_data.dart';
import '../../utils/app_state.dart';
import 'api_urls.dart';

Future<Map<String, dynamic>> getKeysLists(String languageCode) async {
  try {
    http.Response response;
    response = await http.get(Uri.parse("${ApiUrls.keysLists}?lang_code=$languageCode"));
    
    var res = json.decode(response.body);
    print(res);
    if (response.statusCode == 200) {
    return res['data'];
  } else {
    return <String, dynamic>{};
  }
  }  catch (e) {
    print(e);
    return <String, dynamic>{};
  }
}


Future<SettingData> initSettings() async {
  try {
    http.Response response;
    // print(Urls.settings);
    response = await http.get(Uri.parse(ApiUrls.appSetting));
    var res=  json.decode(response.body);
    print(res);
    if (response == null) {
      return SettingData.fromJson({});
    } else if (response.statusCode == 200) {
      appState.setting.value = SettingData.fromJson(res['data']);
      appState.setting.notifyListeners();
      return appState.setting.value;
    } else {
      return SettingData.fromJson({});
    }
  }  catch (e) {
    print(e.toString());
    return SettingData();
  }
}
