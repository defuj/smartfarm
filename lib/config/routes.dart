import 'package:smartfarm/repositories.dart';

var getRoutes = [
  GetPage(
    name: '/splash',
    page: () => const Splash(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/login',
    page: () => const Login(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/home',
    page: () => const Home(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/change-password',
    page: () => const ChangePassword(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/change-email',
    page: () => const ChangeEmail(),
    transition: Transition.cupertino,
  ),
];
