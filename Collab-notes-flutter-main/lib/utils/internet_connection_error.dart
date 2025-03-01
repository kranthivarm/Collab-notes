import 'dart:io';

import 'package:http/http.dart';

String checkInternetConnectionError(e) {
  if(e is SocketException || e is ClientException) {
    return "Check your internet connection";
  }
  return e;
}