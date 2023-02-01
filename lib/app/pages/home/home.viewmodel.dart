import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class HomeViewModel extends ViewModel {
  String _selected = 'Aklimatisasi';
  String get selected => _selected;
  set selected(String value) {
    _selected = value;
    notifyListeners();
  }

  List<String> _list = [
    'Aklimatisasi',
    'Pemeliharaan',
    'Pengolahan',
    'Pengiriman',
    'Lokasi Pabrik'
  ];
  List<String> get list => _list;
  set list(List<String> value) {
    _list = value;
    notifyListeners();
  }

  void signOut() {
    SweetDialog(
      context: context,
      title: 'Keluar dari akun?',
      content: 'Apakah anda yakin ingin keluar dari akun?',
      confirmText: 'Ya',
      cancelText: 'Tidak',
      onConfirm: () {
        Get.offAllNamed('/login');
      },
    ).show();
  }

  void changePassword() {
    try {
      Get.toNamed('/change-password');
    } catch (e) {
      log(e.toString());
    }
  }

  void changeEmail() {
    try {
      Get.toNamed('/change-email');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void init() {}

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
