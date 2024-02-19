import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:wallpaper_app/screens/secrets.dart';

class GetApiDataRepository {
  Future<Uint8List> getPromptResult(String prompt) async {
    final dio = Dio();
    final headers = {"Authorization": "Bearer $imagineAPIKey"};
    final formdata = FormData.fromMap({"prompt": prompt, "style_id": 31});
    final response = await dio.post(
        'https://api.vyro.ai/v1/imagine/api/generations',
        options: Options(
            method: "POST", headers: headers, responseType: ResponseType.bytes),
        data: formdata);

    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print(response.statusMessage);
    }
    return Uint8List.fromList(response.data);
  }
}
