import 'package:smartfarm/repositories.dart';

Widget videoLoading() {
  return Container(
    color: Colors.black,
    child: const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          IColors.green50,
        ),
      ),
    ),
  );
}
