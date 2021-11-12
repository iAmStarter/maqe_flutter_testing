import 'package:http/http.dart' as http;
import 'package:mage_flutter_testing/models/leave.dart';

const String jsonUrl = 'maqe.github.io';

class DataService {
  var url = Uri.https('maqe.github.io', '/json/holidays.json');

  Future<Leave> getData() async {
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return Leave.fromRawJson(res.body);
    } else {
      return Future.error(res);
    }
  }
}
