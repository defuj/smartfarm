import 'package:smartfarm/repositories.dart';

class LoginViewModel extends ViewModel {
  late SweetDialog loading;
  final box = GetStorage();

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  void createAuth() async {
    loading.show();
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          // get user data
          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user != null) {
              loading.dismiss();

              box.write('email', email);
              box.write('password', password);

              Get.offAllNamed('/home');
            } else {
              loading.dismiss();
              SweetDialog(
                context: context,
                dialogType: SweetDialogType.error,
                title: 'Gagal Masuk',
                content: 'Email atau password salah',
                confirmText: 'Oke',
              ).show();
            }
          });
        } else {
          loading.dismiss();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Gagal Masuk',
            content: 'Akun tidak ditemukan',
            confirmText: 'Oke',
          ).show();
        }
      }).catchError((error) {
        loading.dismiss();
        SweetDialog(
          context: context,
          dialogType: SweetDialogType.error,
          title: 'Gagal Masuk',
          content: error.toString().contains('user-not-found')
              ? 'Akun tidak ditemukan'
              : 'Email atau password salah',
          confirmText: 'Oke',
        ).show();
      });
    } catch (e) {
      loading.dismiss();
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Gagal Masuk',
        content: e.toString(),
        confirmText: 'Oke',
      ).show();
    }
  }

  void checkRequirement() {
    if (email.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Email kosong',
        content: 'Silahkan isi email anda',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    if (!validateEmail(email)) {
      SweetDialog(
        context: context,
        title: 'Email tidak valid',
        content: 'Silahkan isi email anda dengan benar',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    if (password.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Kata sandi kosong',
        content: 'Silahkan isi kata sandi anda',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    createAuth();
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
