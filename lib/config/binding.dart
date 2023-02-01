import 'package:smartfarm/repositories.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
  }
}
