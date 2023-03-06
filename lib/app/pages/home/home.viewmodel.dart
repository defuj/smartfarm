import 'dart:async';
import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class HomeViewModel extends ViewModel {
  final AnimationController animationController;
  HomeViewModel({required this.animationController});

  late SweetDialog loading;
  late Animation<double> animation;

  StreamSubscription<DatabaseEvent>? humiditySubscription;
  StreamSubscription<DatabaseEvent>? temperatureSubscription;
  StreamSubscription<DatabaseEvent>? blowerSubscription;
  StreamSubscription<DatabaseEvent>? lastUpdatedSubscription;

  final box = GetStorage();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  bool _isSwitching = false;
  bool get isSwitching => _isSwitching;
  set isSwitching(bool value) {
    _isSwitching = value;
    notifyListeners();
  }

  bool _fanIsActive = false;
  bool get fanIsActive => _fanIsActive;
  set fanIsActive(bool value) {
    _fanIsActive = value;
    notifyListeners();

    // Jika blower aktif, maka jalankan animasi
    if (value) {
      animationController.repeat();
      Future.delayed(const Duration(milliseconds: 1000), () {
        animationController.stop();
      });
    } else {
      animationController.stop();
    }
  }

  String _humidity = '-';
  String get humidity => _humidity;
  set humidity(String value) {
    _humidity = value;
    notifyListeners();
  }

  String _lastUpdated = '-';
  String get lastUpdated => _lastUpdated;
  set lastUpdated(String value) {
    _lastUpdated = value;
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

  void switchLocation(String location) {
    if (selected != location) {
      try {
        humiditySubscription!.cancel();
        temperatureSubscription!.cancel();
        blowerSubscription!.cancel();
        lastUpdatedSubscription!.cancel();
      } catch (e) {
        log(e.toString());
      }

      isSwitching = true;
      selected = location;

      startMonitoring();

      Future.delayed(const Duration(seconds: 2), () {
        isSwitching = false;
      });
    }
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

  void updateBlower(bool status) async {
    try {
      await ref.child('data').child('blower').set(status ? 1 : 0).then((value) {
        fanIsActive = status ? true : false;
      }, onError: (error) {
        fanIsActive = status ? false : true;
      });
    } catch (e) {
      log(e.toString());
      fanIsActive = status ? false : true;
    }
  }

  void startMonitoring() async {
    // blower
    blowerSubscription =
        ref.child('data').child('blower').onValue.listen((DatabaseEvent event) {
      try {
        if (event.snapshot.exists) {
          final data = event.snapshot.value;
          if (data != null) {
            fanIsActive = data == 0 ? false : true;
          }
          log('Result: $data');
        } else {
          fanIsActive = false;
        }
      } catch (e) {
        log('Error $e');
        fanIsActive = false;
      }
    });

    // humidity
    humiditySubscription = ref
        .child('data')
        .child('kelembaban')
        .onValue
        .listen((DatabaseEvent event) {
      try {
        if (event.snapshot.exists) {
          final data = event.snapshot.value;
          if (data != null) {
            humidity = data.toString();
          }
          log('Result: $data');
        } else {
          humidity = '-';
        }
      } catch (e) {
        log('Error $e');
        humidity = '-';
      }
    });

    // temperature
    temperatureSubscription =
        ref.child('data').child('suhu').onValue.listen((DatabaseEvent event) {
      try {
        if (event.snapshot.exists) {
          final data = event.snapshot.value;
          if (data != null) {
            temperature = data.toString();
          }
          log('Result: $data');
        } else {
          temperature = '-';
        }
      } catch (e) {
        log('Error $e');
        temperature = '-';
      }
    });

    // time updated
    lastUpdatedSubscription =
        ref.child('data').child('time').onValue.listen((event) {
      try {
        if (event.snapshot.exists) {
          final milliseconds = event.snapshot.value as int;
          // Hitung selisih waktu antara sekarang dengan waktu terakhir update
          Duration diff = DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(milliseconds));

          // Konversi selisih waktu menjadi menit, jam, atau hari
          int minutes = diff.inMinutes;
          int hours = diff.inHours;
          int days = diff.inDays;

          if (days > 0) {
            lastUpdated = 'Terakhir update $days hari yang lalu';
          } else {
            if (hours > 0) {
              if (minutes % 60 == 0) {
                lastUpdated = 'Terakhir update $hours jam yang lalu';
              } else {
                lastUpdated =
                    'Terakhir update $hours jam ${minutes - 60} menit yang lalu';
              }
            } else {
              if (minutes < 60) {
                log('Minutes: $minutes');
                if (minutes == 0) {
                  lastUpdated = 'Baru saja diperbarui';
                } else {
                  lastUpdated = 'Terakhir update $minutes menit yang lalu';
                }
              } else {
                if (minutes % 60 == 0) {
                  lastUpdated = 'Terakhir update $hours jam yang lalu';
                } else {
                  lastUpdated =
                      'Terakhir update $hours jam ${minutes - 60} menit yang lalu';
                }
              }
            }
          }
        } else {
          lastUpdated = '-';
        }
      } catch (e) {
        log('Error $e');
        lastUpdated = '-';
      }
    });
  }

  @override
  void init() {
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.duration = const Duration(milliseconds: 1000);
    animationController.repeat();

    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAccount();
      startMonitoring();

      animationController.stop();
    });

    // Future.delayed(Duration.zero, () {
    //   checkAccount();
    //   startMonitoring();
    // });
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
