bool validateEmail(String email) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  return regex.hasMatch(email);
}
