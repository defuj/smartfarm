import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class ConfigViewModel extends ViewModel {
  late SweetDialog loading;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  var controller = TextEditingController(text: '');

  String _temperature = '';
  String get temperature => _temperature;
  set temperature(String value) {
    _temperature = value;
    notifyListeners();
  }

  void getLastTemperature() async {
    try {
      var data = await ref.child('konfigurasi').child('batas_suhu').once();

      if (data.snapshot.exists) {
        log(data.snapshot.value.toString());
        controller.text = data.snapshot.value.toString();
        temperature = data.snapshot.value.toString();
      }
    } catch (e) {
      controller.text = '0';
      temperature = '0';
    }
  }

  void changeTemperature() async {
    if (temperature.isNotEmpty) {
      loading.show();
      await ref
          .child('konfigurasi')
          .child('batas_suhu')
          .set(int.parse(temperature))
          .then((value) {
        loading.dismiss();
        SweetDialog(
          context: context,
          title: 'Berhasil',
          content: 'Perubahan batas suhu telah berhasil disimpan',
          dialogType: SweetDialogType.success,
          barrierDismissible: false,
          onConfirm: () {
            loading.dismiss;
          },
        ).show();
      }).catchError((error) {
        loading.dismiss();
        SweetDialog(
          context: context,
          title: 'Gagal Menyimpan',
          content: 'Perubahan batas suhu gagal, silahkan coba lagi',
          dialogType: SweetDialogType.error,
          barrierDismissible: false,
          onConfirm: () {
            loading.dismiss;
          },
        ).show();
      });
    } else {
      SweetDialog(
        context: context,
        title: 'Batas Suhu Kosong',
        content: 'Harap masukan batas suhu untuk melanjutkan perubahan',
        dialogType: SweetDialogType.error,
      ).show();
    }
  }

  @override
  void init() {
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
    Future.delayed(Duration.zero, () {
      getLastTemperature();
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
