import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class HomeViewModel extends ViewModel {
  late SweetDialog loading;
  final box = GetStorage();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  bool _fanIsActive = false;
  bool get fanIsActive => _fanIsActive;
  set fanIsActive(bool value) {
    _fanIsActive = value;
    notifyListeners();
  }

  String _humidity = '-';
  String get humidity => _humidity;
  set humidity(String value) {
    _humidity = value;
    notifyListeners();
  }

  String _temperature = '-';
  String get temperature => _temperature;
  set temperature(String value) {
    _temperature = value;
    notifyListeners();
  }

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

  void signOut() async {
    SweetDialog(
      context: context,
      title: 'Keluar dari akun?',
      content: 'Apakah anda yakin ingin keluar dari akun?',
      confirmText: 'Ya',
      cancelText: 'Tidak',
      onConfirm: () {
        box.erase();
        FirebaseAuth.instance.signOut();
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

  void changeConfig() {
    try {
      Get.toNamed('/config');
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

  void openVideoMonitoring() {
    try {
      Get.toNamed('/video');
    } catch (e) {
      log(e.toString());
    }
  }

  void checkAccount() async {
    loading.show();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          loading.dismiss();
        } else {
          box.erase();
          FirebaseAuth.instance.signOut();
          loading.dismiss();
          SweetDialog(
            context: context,
            title: 'Akun tidak ditemukan',
            content: 'Silahkan masuk kembali',
            confirmText: 'Oke',
            barrierDismissible: false,
            onConfirm: () => Get.offAllNamed('/login'),
          ).show();
        }
      });
    } else {
      await box.erase();
      await FirebaseAuth.instance.signOut();
      loading.dismiss();
      SweetDialog(
        context: context,
        title: 'Akun tidak ditemukan',
        content: 'Silahkan masuk kembali',
        confirmText: 'Oke',
        barrierDismissible: false,
        onConfirm: () => Get.offAllNamed('/login'),
      ).show();
    }
  }

  void startMonitoring() async {
    // blower
    ref.child('data').child('blower').onValue.listen((DatabaseEvent event) {
      try {
        final data = event.snapshot.value;
        if (data != null) {
          fanIsActive = data == 0 ? false : true;
        }
        log('Result: $data');
      } catch (e) {
        log('Error $e');
        fanIsActive = false;
      }
    });

    // humidity
    ref.child('data').child('kelembaban').onValue.listen((DatabaseEvent event) {
      try {
        final data = event.snapshot.value;
        if (data != null) {
          humidity = data.toString();
        }
        log('Result: $data');
      } catch (e) {
        log('Error $e');
        humidity = '-';
      }
    });

    // temperature
    ref.child('data').child('suhu').onValue.listen((DatabaseEvent event) {
      try {
        final data = event.snapshot.value;
        if (data != null) {
          temperature = data.toString();
        }
        log('Result: $data');
      } catch (e) {
        log('Error $e');
        temperature = '-';
      }
    });
  }

  @override
  void init() {
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );

    Future.delayed(Duration.zero, () {
      checkAccount();
      startMonitoring();
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
