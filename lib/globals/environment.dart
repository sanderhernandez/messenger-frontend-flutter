import 'dart:io';

class Environment {
  final String path;

  Environment({required this.path});

  // Datos estáticos:
  static String scheme = 'http';
  static String host = '192.168.1.250';
  static int port = 3000;

  // Para IOS:
  static String _iosHost = 'localhost';

  static String get iosHost => _iosHost;

  Uri get apiUrl => Platform.isAndroid
      ? Uri(scheme: scheme, port: port, host: host, path: path)
      : Uri(scheme: scheme, port: port, host: iosHost, path: path);

  static String socketUrl =
      Platform.isAndroid ? '$scheme://$host:$port' : '$scheme://$host:$port';
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
