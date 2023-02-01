import 'package:smartfarm/repositories.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<EmailViewModel>(
      view: () => const _View(),
      viewModel: EmailViewModel(),
    );
  }
}

class _View extends StatelessView<EmailViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: 'Perbaharui Email',
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
                'Perbahaui Email',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 4),
              Text(
                'Silahkan masukan email baru',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 24),
              Text(
                'Email Baru',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: IColors.gray900),
              ),
              const SizedBox(height: 4),
              InputText(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Masukan Email Baru',
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
                text: 'Perbaharui Email',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
