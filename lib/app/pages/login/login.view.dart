import 'package:smartfarm/repositories.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<LoginViewModel>(
      view: () => const _View(),
      viewModel: LoginViewModel(),
    );
  }
}

class _View extends StatelessView<LoginViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: IColors.backgroundLogin,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 16),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Smart Farm',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: IColors.green800,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by Sadigit',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: IColors.gray800),
                    ),
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/images/image_login.png',
                      width: MediaQuery.of(context).size.width - 32,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang Kembali',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: IColors.gray900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Silahkan masuk untuk mengatur perangkat',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: IColors.gray900),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Alamat Email',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: IColors.gray900),
                      ),
                      const SizedBox(height: 4),
                      InputText(
                        padding: const EdgeInsets.only(
                          left: 0,
                          right: 16,
                        ),
                        onChanged: (value) => viewModel.email = value,
                        hintText: 'Masukkan alamat email',
                        prefixIcon: Container(
                          color: IColors.gray100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 13,
                          ),
                          margin: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            Icons.alternate_email_rounded,
                            color: IColors.green900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Kata Sandi',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: IColors.gray900),
                      ),
                      const SizedBox(height: 4),
                      InputPassword(
                        padding: const EdgeInsets.only(
                          left: 0,
                          right: 0,
                        ),
                        onChanged: (value) => viewModel.password = value,
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
                        text: 'Masuk',
                        onPressed: viewModel.checkRequirement,
                      ),
                      const SizedBox(height: 56),
                      Center(
                        child: Text(
                          'Smart Farm by Sadigit',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: IColors.gray800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
