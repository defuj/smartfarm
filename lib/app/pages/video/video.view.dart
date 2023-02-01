import 'package:smartfarm/repositories.dart';

class VideoMonitoring extends StatelessWidget {
  const VideoMonitoring({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<VideoViewModel>(
      view: () => const _View(),
      viewModel: VideoViewModel(),
    );
  }
}

class _View extends StatelessView<VideoViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: 'Video',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          videoPlayer(context, viewModel),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Text(
              'Video ${viewModel.video.videoName}',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600, color: IColors.gray800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Text(
              'Kamera tersedia',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w600, color: IColors.gray800),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StaggeredGrid.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  children: [
                    for (var video in viewModel.videos)
                      InkWell(
                        onTap: () => viewModel.changeVideo(video),
                        splashColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: viewModel.video.videoID == video.videoID
                                ? IColors.green50
                                : Colors.white,
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
                                  width: 24,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kamera 1',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: IColors.green800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                viewModel.video == video
                                    ? 'Sedang Diputar'
                                    : 'Lihat Video',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: IColors.green800,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
