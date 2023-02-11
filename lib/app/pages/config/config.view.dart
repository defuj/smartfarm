import 'package:smartfarm/repositories.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<ConfigViewModel>(
      view: () => const _View(),
      viewModel: ConfigViewModel(),
    );
  }
}

class _View extends StatelessView<ConfigViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: 'Pengaturan Suhu',
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
                'Atur sensor suhu',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 4),
              Text(
                'Silahkan masukan suhu minimum & maksimum',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: IColors.green900),
              ),
              const SizedBox(height: 24),
              Text(
                'Batas Suhu',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: IColors.gray900),
              ),
              const SizedBox(height: 4),
              InputText(
                onChanged: (value) => viewModel.temperature = value,
                controller: viewModel.controller,
                keyboardType: TextInputType.number,
                hintText: 'Masukan Batas Suhu',
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
                  margin: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.thermostat_rounded,
                    color: IColors.green900,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                text: 'Simpan',
                onPressed: () => viewModel.changeTemperature(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
