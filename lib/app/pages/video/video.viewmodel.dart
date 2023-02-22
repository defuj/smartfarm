import 'dart:async';
import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class VideoViewModel extends ViewModel {
  late Future<void> _initializeVideoPlayerFuture;
  Future<void> get initializeVideoPlayerFuture => _initializeVideoPlayerFuture;
  set initializeVideoPlayerFuture(Future<void> value) {
    _initializeVideoPlayerFuture = value;
    notifyListeners();
  }

  bool hasPlayed = false;

  bool _isLive = true;
  bool get isLive => _isLive;
  set isLive(bool value) {
    _isLive = value;
    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool _isControllerShow = false;
  bool get isControllerShow => _isControllerShow;
  set isControllerShow(bool value) {
    _isControllerShow = value;
    notifyListeners();
  }

  Timer? timer;

  double _videoAspectRatio = 16 / 9;
  double get videoAspectRatio => _videoAspectRatio;
  set videoAspectRatio(double value) {
    _videoAspectRatio = value;
    notifyListeners();
  }

  late VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;
  set controller(VideoPlayerController? value) {
    _controller = value;
    notifyListeners();
  }

  VideoModel _video = VideoModel(
    videoID: '1',
    videoUrl:
        'https://cctvjss.jogjakota.go.id/atcs/ATCS_Simpang_Galeria_TimurSelatan.stream/chunklist_w446327975.m3u8',
    videoName: 'Video 1',
    videoFormat: VideoFormat.hls,
  );
  VideoModel get video => _video;
  set video(VideoModel value) {
    _video = value;
    notifyListeners();
  }

  List<VideoModel> videos = [
    VideoModel(
      videoID: '1',
      videoUrl:
          'https://cctvjss.jogjakota.go.id/atcs/ATCS_Simpang_Galeria_TimurSelatan.stream/chunklist_w446327975.m3u8',
      videoName: 'Video 1',
      videoFormat: VideoFormat.hls,
    ),
    VideoModel(
      videoID: '2',
      videoUrl:
          'https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8',
      videoName: 'Video 2',
      videoFormat: VideoFormat.hls,
    ),
    VideoModel(
      videoID: '3',
      videoUrl:
          'https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4',
      videoName: 'Video 3',
      videoFormat: VideoFormat.other,
    )
  ];

  void hideVideoController() {
    isControllerShow = false;
  }

  void showVideoController() {
    try {
      if (controller!.value.isInitialized) {
        isControllerShow = true;

        if (timer != null) {
          timer?.cancel();
        }
        timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          isControllerShow = false;
          timer.cancel();
        });
      }
    } catch (e) {
      log('Error: $e', name: 'VideoViewModel.showVideoController');
    }
  }

  void showOrHideVideoController() {
    log('showOrHideVideoController: ${controller!.value.isInitialized}');
    if (controller!.value.isInitialized) {
      if (isControllerShow) {
        hideVideoController();
      } else {
        showVideoController();
      }
    }
  }

  void playVideo() {
    try {
      // if (controller!.value.position == controller!.value.duration) {
      //   controller?.seekTo(Duration.zero);
      //   controller?.play();
      //   hasPlayed = true;
      //   isPlaying = true;

      //   showVideoController();
      // } else {
      //   controller?.play();
      //   hasPlayed = true;
      //   isPlaying = true;

      //   showVideoController();
      // }
      controller?.play();
      hasPlayed = true;
      isPlaying = true;

      showVideoController();
    } catch (e) {
      log('Error: $e', name: 'VideoViewModel.playVideo');
    }
  }

  void pauseVideo() {
    try {
      if (controller!.value.isInitialized) {
        if (controller!.value.isPlaying) {
          controller?.pause();
          isPlaying = false;
          showVideoController();
        }
      }
    } catch (e) {
      log('Error: $e', name: 'VideoViewModel.pauseVideo');
    }
  }

  void playNextVideo() {
    try {
      if (videos.length > 1) {
        final index =
            videos.indexWhere((element) => element.videoID == video.videoID);
        if (index < videos.length - 1) {
          changeVideo(videos[index + 1]);
        }
      }
    } catch (e) {
      log('Error: $e', name: 'VideoViewModel.playNextVideo');
    }
  }

  void playPreviousVideo() {
    try {
      if (videos.length > 1) {
        final index =
            videos.indexWhere((element) => element.videoID == video.videoID);
        if (index > 0) {
          changeVideo(videos[index - 1]);
        }
      }
    } catch (e) {
      log('Error: $e', name: 'VideoViewModel.playPreviousVideo');
    }
  }

  void changeVideo(VideoModel video) async {
    this.video = video;
    hideVideoController();
    try {
      controller = VideoPlayerController.network(
        video.videoUrl!,
        formatHint: video.videoFormat,
      );
      controller?.addListener(() {
        log('isPlaying: ${controller!.value.isPlaying}');
        log('position: ${controller!.value.position}');
        log('isInitialized: ${controller!.value.isInitialized}');

        if (controller!.value.isPlaying) {
          if (controller!.value.position == controller!.value.duration) {
            // isPlaying = false;
            // showVideoController();
          }
        } else {
          //   isPlaying = false;
          //   showVideoController();
        }
      });
      //   controller?.setLooping(false);
      controller?.setVolume(1.0);
      //   controller?.initialize().then((_) {
      //     videoAspectRatio = controller!.value.aspectRatio;
      //     playVideo();
      //     notifyListeners();
      //   });
      initializeVideoPlayerFuture = controller!.initialize().then((_) {
        videoAspectRatio = controller!.value.aspectRatio;
        playVideo();
        notifyListeners();
        log('controller initialized');
      });
      //   initializeVideoPlayerFuture = controller!.initialize();
      //   videoAspectRatio = controller!.value.aspectRatio;
      //   playVideo();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void init() {
    changeVideo(videos[0]);

    // https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8
    // https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onUnmount() {
    try {
      if (hasPlayed) {
        controller?.dispose();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onResume() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onPause() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInactive() {
    try {
      if (hasPlayed) {
        controller?.dispose();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onDetach() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
