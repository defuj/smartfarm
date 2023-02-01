import 'package:smartfarm/repositories.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<SplashViewModel>(
      view: () => const _View(),
      viewModel: SplashViewModel(),
    );
  }
}

class _View extends StatelessView<SplashViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/smartfarm_icon.png',
              width: 190,
              height: 190,
            ),
            const SizedBox(height: 24),
            Text(
              'Smart Farm',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontWeight: FontWeight.w600, color: colorGreen.shade900),
            ),
            const SizedBox(height: 4),
            Text(
              'by Sadigit',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: IColors.gray800),
            ),
          ],
        ),
      ),
    );
  }
}
