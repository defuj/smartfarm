import 'dart:io';
import 'package:smartfarm/repositories.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  var lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
  );

  //   var darkTheme = ThemeData(
  //     useMaterial3: true,
  //     colorScheme: darkColorScheme,
  //     textTheme: textTheme,
  //   );
  await PackageInfo.fromPlatform();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: 'Dunia Buah',
      theme: lightTheme,
      //   darkTheme: darkTheme,
      initialRoute: '/splash',
      getPages: getRoutes,
      initialBinding: MainBinding(),
    ),
  );
}
