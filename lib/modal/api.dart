import 'package:http/http.dart' as http;

class Api {
  get(String url,Map<String,String> headers) async {
    var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json", }..addAll(headers));
    return response.body;
  }

  post(String url, var value) async {
    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: value);
    return response.body;
  }
}
