import 'package:smartfarm/repositories.dart';

class PasswordViewModel extends ViewModel {
  late SweetDialog loading;
  final box = GetStorage();

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  String _newPassword = '';
  String get newPassword => _newPassword;
  set newPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  void changePassword() async {
    loading.show();
    final currentPassword = box.read('password');
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loading.dismiss();
        box.erase();
        Get.offAllNamed('/login');
      } else {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        user.reauthenticateWithCredential(credential).then((value) {
          user.updatePassword(newPassword).then((value) {
            loading.dismiss();
            box.write('password', newPassword);
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.success,
              title: 'Berhasil',
              content: 'Kata sandi berhasil diperbaharui',
              confirmText: 'Kembali',
              onConfirm: () {
                Get.back();
              },
            ).show();
          }).catchError((error) {
            loading.dismiss();
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Gagal',
              content: error.toString(),
            ).show();
          });
        }).catchError((error) {
          loading.dismiss();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Gagal',
            content: error.toString(),
          ).show();
        });
      }
    });
  }

  void checkPassword() {
    if (password.isEmpty) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Kata Sandi Kosong',
        content: 'Kata sandi tidak boleh kosong, silahkan isi kata sandi anda',
        confirmText: 'Oke',
      ).show();
      return;
    }

    if (newPassword.isEmpty) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Kata Sandi Baru Kosong',
        content:
            'Kata sandi baru tidak boleh kosong, silahkan isi kata sandi baru anda',
        confirmText: 'Oke',
      ).show();
      return;
    }

    if (confirmPassword.isEmpty) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Konfirmasi Kata Sandi Kosong',
        content:
            'Konfirmasi kata sandi tidak boleh kosong, silahkan isi konfirmasi kata sandi anda',
        confirmText: 'Oke',
      ).show();
      return;
    }

    if (newPassword != confirmPassword) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Kata sandi tidak sama',
        content:
            'Kata sandi dan konfirmasi kata sandi tidak sama, silahkan cek kembali kata sandi anda',
        confirmText: 'Oke',
      ).show();
      return;
    }

    if (password != box.read('password')) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Kata sandi lama salah',
        content:
            'Kata sandi lama yang anda masukkan salah, silahkan cek kembali kata sandi anda',
        confirmText: 'Oke',
      ).show();
      return;
    }

    changePassword();
  }

  @override
  void init() {
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
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
