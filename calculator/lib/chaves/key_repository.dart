// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

delete_key_from_repo({required String keyIdentificator}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(keyIdentificator);
}

delete_encoded_message_from_repo({required String messageKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(messageKey);
}

storePrivateKey_P({required int pKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('private_key_p', pKey);
}

storePrivateKey_Q({required int qKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('private_key_q', qKey);
}

storePrivateKey_D({required int dKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('private_key_d', dKey);
}

storePublicKey_N({required int nKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('public_key_n', nKey);
}

storePublicKey_E({required int eKey}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('public_key_e', eKey);
}

storeEncoded_Message({required List<String> message}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('encoded_message', message);
}

