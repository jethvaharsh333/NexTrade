import 'dart:io';

import 'package:flutter/foundation.dart';

class AppSecrets {
  static String get SERVER_API_URL {
    if (kIsWeb) {
      print("web");
      return "http://10.20.51.24:5079/api/";  // For web
    } else if (Platform.isAndroid) {
      print("android");
      return "http://10.0.2.2:5079/api/";   // For Android emulator
    } else if (Platform.isIOS) {
      print("IOS");
      return "http://localhost:5000/api/";   // For iOS simulator
    } else {
      print("default");
      return "http://localhost:5000/api/";   // Default fallback
    }
  }
}