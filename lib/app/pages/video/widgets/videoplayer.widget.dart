import 'package:smartfarm/repositories.dart';

Widget videoPlayer(BuildContext context, VideoViewModel viewModel) {
  return AspectRatio(
    aspectRatio: viewModel.videoAspectRatio,
    child: Stack(
      children: [
        viewModel.controller != null
            ? viewModel.controller!.value.isInitialized
                ? VideoPlayer(viewModel.controller!)
                : videoLoading()
            : videoLoading(),
        AnimatedOpacity(
          opacity: viewModel.isControllerShow ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: InkWell(
            onTap: viewModel.showOrHideVideoController,
            child: Container(
              color: IColors.blacktransparant,
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => viewModel.playPreviousVideo(),
                          child: SvgPicture.asset(
                            'assets/icons/svg/video_back.svg',
                            color: IColors.whitetransparant,
                            width: 20,
                          ),
                        ),
                        const SizedBox(width: 40),
                        InkWell(
                          onTap: () => viewModel.isPlaying
                              ? viewModel.pauseVideo()
                              : viewModel.playVideo(),
                          child: SvgPicture.asset(
                            viewModel.isPlaying
                                ? 'assets/icons/svg/video_pause.svg'
                                : 'assets/icons/svg/video_play.svg',
                            color: IColors.whitetransparant,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 40),
                        InkWell(
                          onTap: () => viewModel.playNextVideo(),
                          child: SvgPicture.asset(
                            'assets/icons/svg/video_next.svg',
                            color: IColors.whitetransparant,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(viewModel.context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Visibility(
                              visible: viewModel.isLive,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Live',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SliderTheme(
                              data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay,
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 3.0,
                                ),
                                trackShape: const RectangularSliderTrackShape(),
                              ),
                              child: Slider(
                                activeColor: Colors.red,
                                inactiveColor: IColors.gray100,
                                min: 0.0,
                                max: viewModel.isLive
                                    ? 100.0
                                    : viewModel.controller!.value.duration
                                        .inMilliseconds
                                        .toDouble(),
                                value: viewModel.isLive
                                    ? 100.0
                                    : viewModel.controller!.value.position
                                        .inMilliseconds
                                        .toDouble(),
                                onChanged: (value) {},
                              ),
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
        ),
      ],
    ),
  );
}
