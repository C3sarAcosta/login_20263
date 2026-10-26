import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifierProvider {
  final String _baseUrl = 'https://receta20263it.somee.com/api';

  final storage = new FlutterSecureStorage();

  new value({required super.value}) : super.value();

  Future<String?> createdUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };
    
    final url = Uri.http(_baseUrl, '/Accounts/register');
    final resp = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if(decodeResp.containsKey('token')){
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.https(_baseUrl, '/Accounts/login');

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

}