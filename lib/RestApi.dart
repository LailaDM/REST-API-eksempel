import 'dart:convert';
import 'package:http/http.dart';
import 'user.dart';

class RestApi {
  final String testURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<User>> getData() async {
    Response response = await get(Uri.parse(testURL));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<User> data = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return data;
    } else {
      throw "No data found";
    }
  }
}
