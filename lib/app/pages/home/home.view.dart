import 'package:smartfarm/repositories.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<HomeViewModel>(
      view: () => const _View(),
      viewModel: HomeViewModel(),
    );
  }
}

class _View extends StatelessView<HomeViewModel> {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Smart Farm',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
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
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          context: context,
                          builder: ((context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 24,
                                        top: 16,
                                      ),
                                      height: 4,
                                      width: 80,
                                      decoration: const BoxDecoration(
                                        color: IColors.neutral20,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      'Pengaturan Akun',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                            color: IColors.gray800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  //   InkWell(
                                  //     onTap: viewModel.changeEmail,
                                  //     child: Container(
                                  //       width: double.infinity,
                                  //       padding: const EdgeInsets.symmetric(
                                  //         horizontal: 16,
                                  //         vertical: 8,
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Container(
                                  //             margin: const EdgeInsets.only(
                                  //               right: 12,
                                  //             ),
                                  //             width: 36,
                                  //             height: 30,
                                  //             child: const Center(
                                  //               child: Icon(
                                  //                 Icons.alternate_email_rounded,
                                  //                 color: IColors.green600,
                                  //                 size: 24,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           Expanded(
                                  //             child: Text(
                                  //               'Perbaharui Email',
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                       color: IColors.gray800,
                                  //                       fontWeight:
                                  //                           FontWeight.w400),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  InkWell(
                                    onTap: viewModel.changeConfig,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 12,
                                            ),
                                            width: 36,
                                            height: 30,
                                            child: const Center(
                                              child: Icon(
                                                Icons.thermostat_rounded,
                                                color: IColors.green600,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Pengaturan Suhu',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: IColors.gray800,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: viewModel.changePassword,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 12,
                                            ),
                                            width: 36,
                                            height: 30,
                                            child: const Center(
                                              child: Icon(
                                                Icons.password_outlined,
                                                color: IColors.green600,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Perbaharui Kata Sandi',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: IColors.gray800,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: viewModel.signOut,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 12,
                                            ),
                                            width: 36,
                                            height: 30,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/icons/svg/logout_icon.svg',
                                                color: IColors.green600,
                                                width: 24,
                                                height: 24,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Keluar',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: IColors.gray800,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: IColors.green500,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Image.asset(
                  'assets/images/image_home.png',
                  width: MediaQuery.of(context).size.width - 32,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lokasi Perangkat',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: IColors.green800,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          itemCount: viewModel.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                viewModel.selected = viewModel.list[index];
                              },
                              splashColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: viewModel.selected ==
                                          viewModel.list[index]
                                      ? IColors.green500
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: viewModel.selected ==
                                            viewModel.list[index]
                                        ? IColors.green500
                                        : IColors.gray100,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  viewModel.list[index],
                                  style: viewModel.selected ==
                                          viewModel.list[index]
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)
                                      : Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: IColors.gray700,
                                              fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.thermostat_rounded,
                                    color: IColors.green800,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Suhu',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: IColors.gray800),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    viewModel.temperature == '-'
                                        ? '-'
                                        : '${viewModel.temperature}°C',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: IColors.green800,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.water_drop_rounded,
                                    color: IColors.green800,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kelembaban',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: IColors.gray800),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    viewModel.humidity == '-'
                                        ? '-'
                                        : '${viewModel.humidity}% RH',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: IColors.green800,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/svg/fan_icon.svg',
                                    color: IColors.green800,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Blower',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: IColors.gray800),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: viewModel.fanIsActive
                                            ? IColors.green600
                                            : IColors.red50,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        viewModel.fanIsActive
                                            ? 'Aktif'
                                            : 'Mati',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: viewModel.fanIsActive
                                                    ? IColors.green600
                                                    : IColors.red50,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/svg/camera_icon.svg',
                                      color: IColors.green800,
                                      width: 32,
                                      height: 53,
                                    ),
                                  ),
                                  Text(
                                    'Kamera',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: IColors.green800,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '3 Kamera Tersambung',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: IColors.gray600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: ButtonPrimary(
                                text: 'Lihat Video',
                                onPressed: viewModel.openVideoMonitoring,
                              ),
                            ),
                          ],
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
