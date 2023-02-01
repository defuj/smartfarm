import 'package:smartfarm/repositories.dart';

class SplashViewModel extends ViewModel {
  void checkUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.offAllNamed('/login');
      } else {
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.offAllNamed('/login');
    }
  }

  @override
  void init() {
    Future.delayed(const Duration(seconds: 2), () {
      checkUser();
    });
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {}

  @override
  void onUnmount() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}
}
