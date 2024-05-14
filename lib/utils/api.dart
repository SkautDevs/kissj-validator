import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/config.dart';
import '../models/user.dart';
import 'package:uuid/uuid.dart';

Future<User> getUser(String qrCodeData) async {
  if (Uuid.isValidUUID(fromString: qrCodeData) == false) {
    return  User( 'None', 'None', 'None', 0, 'None',
        'None',{}, false, 'Invalid QR code');
  }

  final config = AppConfig();

  final kissjInstance = config.kissjInstance;
  final eventSecret = config.eventSecret;

  var apiUrl = 'https://$kissjInstance/v3/entry/$qrCodeData';
  Map data = {
    'eventSecret': eventSecret
  };
  var body = json.encode(data);
  var response = await http.post(Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    return  User( result['fullName'] ?? 'None',
        result['email'] ?? 'None',
        result['eventName'] ?? 'None',
        result['ageAtEventStart'] ?? 0,
        result['status'] ?? 'None',
        result['entryDateTime'] ?? 'None' ,
        {"Cup":"Yes"}, true, '');
  }

  if (response.statusCode == 403) {
    return  User( 'None', 'None', 'None', 0, 'None',
        'None',{}, false, json.decode(response.body)['reason']);
  }

  return  User( 'None', 'None', 'None', 0, 'None',
      'None',{}, false, 'Unknown error');

}

