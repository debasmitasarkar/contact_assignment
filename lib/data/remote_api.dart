import 'package:contact_assignment/data/models/contact_response.dart';
import 'package:http/http.dart' as http;

class RemoteApi {
  Future<List<Contact>> fetchContactList(pageKey) async {
    try {
      print(pageKey);
      http.Response response = await http.get(Uri.parse(
          'https://612c49f2ab461c00178b5c4c.mockapi.io/api/jm/intv/contacts-$pageKey'));
      return contactResponseFromJson(response.body).data;
    } catch (e) {
      throw e;
    }
  }
}
