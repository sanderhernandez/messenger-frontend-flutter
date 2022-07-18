import 'dart:io';

class Environment {
  final String path;
  // Para android:
  static String androidHost = '192.168.0.8';

  // Para IOS:
  static String _iosHost = 'localhost';

  Environment({required this.path});

  static String get iosHost => _iosHost;

  Uri get apiUrl => Platform.isAndroid
      ? Uri(scheme: 'http', port: 3000, host: androidHost, path: path)
      : Uri(scheme: 'http', port: 3000, host: iosHost, path: path);

  Uri socketUrl = Platform.isAndroid
      ? Uri(scheme: 'http', port: 3000, host: androidHost, path: '')
      : Uri(scheme: 'http', port: 3000, host: iosHost, path: '');
}

// import 'dart:io';
//
// class Environment {
//   // Para android:
//   static String androidHost = '192.168.1.250';
//
//   // Para IOS:
//   static String iosHost = 'localhost';
//
//   static Uri apiUrl = Platform.isAndroid
//       ? Uri(scheme: 'http', port: 3000, host: androidHost, path: 'api/login/')
//       : Uri(scheme: 'http', port: 3000, host: iosHost, path: 'api/login/');
//
//   static Uri socketUrl = Platform.isAndroid
//       ? Uri(scheme: 'http', port: 3000, host: androidHost, path: '')
//       : Uri(scheme: 'http', port: 3000, host: iosHost, path: '');
// }
