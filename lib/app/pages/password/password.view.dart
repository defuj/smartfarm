import 'package:smartfarm/repositories.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<PasswordViewModel>(
      view: () => const _View(),
      viewModel: PasswordViewModel(),
    );
  }
}

class _View extends StatelessView<PasswordViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: 'Perbaharui Kata Sandi',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perbahaui Kata Sandi',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 4),
              Text(
                'Silahkan masukan kata sandi baru',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 24),
              Text(
                'Kata Sandi Lama',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: IColors.gray900),
              ),
              const SizedBox(height: 4),
              InputPassword(
                hintText: 'Masukan kata sandi lama',
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                prefixIcon: Container(
                  color: IColors.gray100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.password_rounded,
                    color: IColors.green900,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Kata Sandi Baru',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: IColors.gray900),
              ),
              const SizedBox(height: 4),
              InputPassword(
                hintText: 'Masukan kata sandi baru',
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                prefixIcon: Container(
                  color: IColors.gray100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.password_rounded,
                    color: IColors.green900,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ulangi Kata Sandi Baru',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: IColors.gray900),
              ),
              const SizedBox(height: 4),
              InputPassword(
                hintText: 'Ulangi kata sandi baru',
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                prefixIcon: Container(
                  color: IColors.gray100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.password_rounded,
                    color: IColors.green900,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                text: 'Perbaharui Kata Sandi',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
